SET @wipe_started_at = UNIX_TIMESTAMP();

DROP TABLE IF EXISTS wiped_players;
CREATE TABLE wiped_players (id INT NOT NULL PRIMARY KEY)
SELECT id FROM players WHERE group_id <= 1 AND name NOT LIKE '%Sample%';

DROP TABLE IF EXISTS wiped_guilds;
CREATE TABLE wiped_guilds (id INT NOT NULL PRIMARY KEY)
SELECT id FROM guilds WHERE ownerid IN (SELECT id FROM wiped_players);

DROP TABLE IF EXISTS wiped_houses;
CREATE TABLE wiped_houses (id INT NOT NULL PRIMARY KEY)
SELECT id FROM houses
WHERE owner IN (SELECT id FROM wiped_players)
   OR guildid IN (SELECT id FROM wiped_guilds);

SELECT
    (SELECT COUNT(*) FROM wiped_players) AS players_to_wipe,
    (SELECT COUNT(*) FROM players) - (SELECT COUNT(*) FROM wiped_players) AS players_to_keep,
    (SELECT COUNT(*) FROM wiped_guilds) AS guilds_to_wipe,
    (SELECT COUNT(*) FROM wiped_houses) AS houses_to_reset;

START TRANSACTION;

DELETE FROM tile_store WHERE house_id IN (SELECT id FROM wiped_houses);
DELETE FROM house_lists WHERE house_id IN (SELECT id FROM wiped_houses);
UPDATE houses
SET owner = 0, new_owner = -1, paid = 0, warnings = 0, guildid = NULL,
    bidder = 0, bidder_name = '', highest_bid = 0, internal_bid = 0,
    bid_end_date = 0, state = 0, transfer_status = 0
WHERE id IN (SELECT id FROM wiped_houses);
UPDATE houses
SET bidder = 0, bidder_name = '', highest_bid = 0, internal_bid = 0, bid_end_date = 0
WHERE bidder IN (SELECT id FROM wiped_players);
UPDATE houses SET new_owner = -1, transfer_status = 0
WHERE new_owner IN (SELECT id FROM wiped_players);

DELETE FROM guildwar_kills
WHERE warid IN (
    SELECT id FROM guild_wars
    WHERE guild1 IN (SELECT id FROM wiped_guilds) OR guild2 IN (SELECT id FROM wiped_guilds)
);
DELETE FROM guild_wars
WHERE guild1 IN (SELECT id FROM wiped_guilds) OR guild2 IN (SELECT id FROM wiped_guilds);
DELETE FROM guild_invites
WHERE guild_id IN (SELECT id FROM wiped_guilds) OR player_id IN (SELECT id FROM wiped_players);
DELETE FROM guild_membership
WHERE guild_id IN (SELECT id FROM wiped_guilds) OR player_id IN (SELECT id FROM wiped_players);
DELETE FROM guild_ranks WHERE guild_id IN (SELECT id FROM wiped_guilds);
DELETE FROM guilds WHERE id IN (SELECT id FROM wiped_guilds);

DELETE FROM market_offers WHERE player_id IN (SELECT id FROM wiped_players);
DELETE FROM market_history WHERE player_id IN (SELECT id FROM wiped_players);
DELETE FROM market_web_orders
WHERE buyer_id IN (SELECT id FROM wiped_players) OR seller_id IN (SELECT id FROM wiped_players);

DELETE FROM account_viplist WHERE player_id IN (SELECT id FROM wiped_players);
DELETE FROM account_vipgrouplist WHERE player_id IN (SELECT id FROM wiped_players);
DELETE FROM player_oldnames WHERE player_id IN (SELECT id FROM wiped_players);
DELETE FROM daily_reward_history WHERE player_id IN (SELECT id FROM wiped_players);
DELETE FROM forge_history WHERE player_id IN (SELECT id FROM wiped_players);
DELETE FROM player_charms WHERE player_id IN (SELECT id FROM wiped_players);
DELETE FROM player_statements WHERE player_id IN (SELECT id FROM wiped_players);
DELETE FROM player_deaths WHERE player_id IN (SELECT id FROM wiped_players);
DELETE FROM player_depotitems WHERE player_id IN (SELECT id FROM wiped_players);
DELETE FROM player_hirelings WHERE player_id IN (SELECT id FROM wiped_players);
DELETE FROM player_inboxitems WHERE player_id IN (SELECT id FROM wiped_players);
DELETE FROM player_items WHERE player_id IN (SELECT id FROM wiped_players);
DELETE FROM player_wheeldata WHERE player_id IN (SELECT id FROM wiped_players);
DELETE FROM player_kills WHERE player_id IN (SELECT id FROM wiped_players);
DELETE FROM player_namelocks WHERE player_id IN (SELECT id FROM wiped_players);
DELETE FROM player_prey WHERE player_id IN (SELECT id FROM wiped_players);
DELETE FROM player_taskhunt WHERE player_id IN (SELECT id FROM wiped_players);
DELETE FROM player_bounty_tasks WHERE player_id IN (SELECT id FROM wiped_players);
DELETE FROM player_weekly_tasks WHERE player_id IN (SELECT id FROM wiped_players);
DELETE FROM player_bosstiary WHERE player_id IN (SELECT id FROM wiped_players);
DELETE FROM player_rewards WHERE player_id IN (SELECT id FROM wiped_players);
DELETE FROM player_spells WHERE player_id IN (SELECT id FROM wiped_players);
DELETE FROM player_stash WHERE player_id IN (SELECT id FROM wiped_players);
DELETE FROM player_storage WHERE player_id IN (SELECT id FROM wiped_players);
DELETE FROM player_elemental_build WHERE player_id IN (SELECT id FROM wiped_players);
DELETE FROM player_gem_bag WHERE player_id IN (SELECT id FROM wiped_players);
DELETE FROM player_outfits WHERE player_id IN (SELECT id FROM wiped_players);
DELETE FROM player_mounts WHERE player_id IN (SELECT id FROM wiped_players);

DELETE kv_store FROM kv_store
JOIN wiped_players ON kv_store.key_name = CONCAT('player.', wiped_players.id)
                   OR kv_store.key_name LIKE CONCAT('player.', wiped_players.id, '.%');

DELETE FROM znote_players WHERE player_id IN (SELECT id FROM wiped_players);
DELETE FROM znote_auction_player WHERE player_id IN (SELECT id FROM wiped_players);
DELETE FROM znote_deleted_characters;

DELETE FROM players WHERE id IN (SELECT id FROM wiped_players);

DELETE FROM players_online;

UPDATE accounts SET coins = 0, coins_transferable = 0, tournament_coins = 0, house_bid_id = 0;
UPDATE znote_accounts SET points = 0;

COMMIT;

SELECT
    (SELECT COUNT(*) FROM players) AS players_remaining,
    (SELECT COUNT(*) FROM player_items) AS player_items_remaining,
    (SELECT COUNT(*) FROM player_depotitems) AS depot_items_remaining,
    (SELECT COUNT(*) FROM guilds) AS guilds_remaining,
    (SELECT COUNT(*) FROM houses WHERE owner <> 0) AS houses_with_owner,
    (SELECT COUNT(*) FROM accounts) AS accounts_kept,
    (SELECT COALESCE(SUM(coins + coins_transferable + tournament_coins), 0) FROM accounts) AS coins_remaining;

SELECT name, group_id FROM players ORDER BY group_id DESC, name;

DROP TABLE IF EXISTS wiped_houses;
DROP TABLE IF EXISTS wiped_guilds;
DROP TABLE IF EXISTS wiped_players;
