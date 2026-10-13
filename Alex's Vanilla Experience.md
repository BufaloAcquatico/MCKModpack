# Alex's Vanilla Experience — Modpack Report

*Report generated 2026-10-14 by inspecting the PrismLauncher instance directly. All data below comes from the instance's own files (`instance.cfg`, `mmc-pack.json`, the packwiz mod index, each jar's `fabric.mod.json`, launch logs) cross-checked with live Modrinth/CurseForge API metadata.*

---

## 1. At a Glance

| Property | Value |
|---|---|
| **Pack / instance name** | Alex's Vanilla Experience |
| **Type** | Custom personal modpack (PrismLauncher instance), *not* a published/ CurseForge- or Modrinth-managed pack (`ManagedPack=false`) |
| **Minecraft version** | 1.20.1 (Java Edition) |
| **Mod loader** | Fabric Loader 0.16.5 |
| **Core API** | Fabric API 0.92.2+1.20.1 |
| **Java runtime** | Microsoft OpenJDK 17.0.15 (64-bit, x86_64), pinned via `java-runtime-gamma` |
| **Mod count** | 130 JARs in `mods/` → **267 mod entries** loaded by Fabric (JAR-in-JAR modules of Fabric API, Kotlin, Zenith, etc.) |
| **Distributions platform** | 129 mods archived via Modrinth metadata; 1 mod (Rusticated) via CurseForge |
| **Mod composition** | 96 content mods, 29 library/API mods, 4 datapacks packaged as mods, 1 container mod (Essential) |
| **Resource packs active** | Fresh Animations v1.9 (+ Moonlight dynamic assets), Stay True 1.21 |
| **Shader pack** | Complementary Reimagined r5.1.1 (for Iris 1.7.5) |
| **Worlds** | 3 saves: "Cappuccino", "Milk and cookies", "Flat test world" |
| **Total playtime** | ≈ 88.4 hours (318,355 s) recorded by the launcher (most recent session 27 s — a quick launch check) |
| **Last launched** | 2026-10-13/14 (instance still actively played) |
| **Setup window** | Bulk mod install 2024-11-13; a few additions/updates 2024-11-17 → 2024-12-02 |

---

## 2. What kind of pack this is

**"Vanilla+ experience" is taken literally.** The design mission is: change how Minecraft *feels* without adding tech, magic, or power creep. Reading the mod roster, four pillars emerge:

1. **Structure & world overhaul without biome replacement.** The pack contains the *entire* YUNG's Better-X suite (all 8 structure mods plus YUNG's Extras and API) — the single most identifiable fingerprint of the pack — plus Towns and Towers, Dungeons and Taverns, Geophilic (a subtle vanilla-biome spruce-up, not ByG-style biome bloat), and Sparse Structures to keep find density sane despite the added structure count. This is the "exploration" pillar.
2. **A performance/visual stack that stays in vanilla aesthetic.** Sodium + ModernFix + EntityCulling for FPS; Iris + Complementary Reimagined + Fresh Animations (with EMF/ETF) for look; Indium keeps Fabric Rendering API mods working under Sodium; Sound Physics Remastered, Dynamic Lights, Visuality, particular, Immersive Thunder, Chunks Fade In handle ambience.
3. **Interface-tinkering QoL, not UI redesign.** BetterF3, AppleSkin, Legendary Tooltips, Effect/Enchantment Descriptions, Mouse Tweaks, Inventory Sorting, Smooth Scrolling, Dark Loading Screen, tip screens on the loading screen (Tips), etc. — all non-intrusive.
4. **Light RPG-ification through Zenith** (the Fabric port of Apotheosis) — deeper enchanting and gem/affix loot — combined with **End Remastered**, which turns the vanilla Eye-of-Ender into a 16-eye hunt (evidently the player's own progression notes are taped into `instance.cfg`, see §7).

It is neither a kitchen-sink (no Create, no new dimensions, no quests, no MCreator mob mods) nor a pure optimization pack (it keeps heavyhitters like Essential, Litematica, Iris, and the full YUNG suite).

---

## 3. How the pack is built (technical anatomy)

The instance is a **PrismLauncher OneSix-style instance** (`InstanceType=OneSix`, `ConfigVersion=1.3`). `mmc-pack.json` declares four components:

- **Minecraft 1.20.1** (`net.minecraft`), pinned
- **LWJGL 3.3.1** (`org.lwjgl3`) — bundled dependency
- **Intermediary Mappings 1.20.1** (`net.fabricmc.intermediary`) — Fabric's obfuscation mapping layer
- **Fabric Loader 0.16.5** (`net.fabricmc.fabric-loader`) — the last 0.16-series release used widely on 1.20.1

Mod resolution is **packwiz-style**: `mods/.index/` holds 129 `.pw.toml` files, each pinning the exact file name, download URL, and SHA-512/SHA-1 hash of a mod version (Modrinth CDN URLs + Modrinth project/version IDs, CurseForge project/file IDs for Rusticated). This is the same mechanism CurseForge/Modrinth `.mrpack` exports use — meaning this instance was likely built from an exported `.mrpack` and then customized, or assembled with a packwiz-like tool and imported into PrismLauncher. Because every hash is pinned, the pack is fully reproducible byte-for-byte.

One notable gap: **`sparsestructures-fabric-1.20.1-2.2.0.jar` was added manually** (file date 2024-11-17, after the 2024-11-13 bulk setup) and has no `.pw.toml` index entry — so any `packwiz refresh`/re-export would drop it. It is accounted for in the table below (row 117, Sparse Structures, Modrinth ID `qwvI41y9`).

Launcher settings of note: `AutomaticJava=true` overridden with a **pinned Microsoft Java 17.0.15 runtime**; memory args, commands, window, performance and miscellaneous are all left at launcher defaults (`Override*=false`); no custom pre-launch commands; `iconKey=default`.

---

## 4. Complete Mod List (130 entries)

*Versions are the actual loaded versions as reported by Fabric Loader in `logs/latest.log` and each jar's `fabric.mod.json`. URLs are the official project pages; all were verified against the Modrinth API on 2026-10-14 (except Rusticated, verified via its CurseForge project ID 750794). "Type" distinguishes content mods from libraries that ship inside the pack for other mods, and 4 datapacks distributed as jars. Note: a handful of projects have since been renamed upstream — the table shows the **current** page name (e.g. Sushi Bar → Bento Box, Effect Descriptions → Effect Insights), while the installed JAR file names are unchanged.*

| # | Mod | Version | Type | Category | Authors | License | Source & URL | What it does |
|---:|---|---|---|---|---|---|---|---|
| 1 | **Advancement Plaques** | 1.6.7 | Mod | QoL Gameplay | Grend | CC BY-NC-ND 4.0 | [Modrinth](https://modrinth.com/mod/advancement-plaques) | Replaces standard advancement toasts with fancy plaques |
| 2 | **Almanac** | 1.0.2 | Library | Core / API Library | frikinjay | LGPL-3.0 | [Modrinth](https://modrinth.com/mod/almanac) | Loader independent library mod for frikinjay's mods |
| 3 | **AppleSkin** | 2.5.1+mc1.20 | Mod | UI / HUD | squeek502 | Unlicense | [Modrinth](https://modrinth.com/mod/appleskin) | Adds various food-related HUD improvements |
| 4 | **Architectury API** | 9.2.14 | Library | Core / API Library | shedaniel | LGPL-3 | [Modrinth](https://modrinth.com/mod/architectury-api) | A intermediary api aimed to ease developing multiplatform mods |
| 5 | **Artifacts** | 9.5.13 | Mod | Content: Exploration | ochotonida, Florens | MIT | [Modrinth](https://modrinth.com/mod/artifacts) | Adds various new powerful uncraftable items to make exploration a bit more interesting |
| 6 | **Ash API** | 3.0.2+1.20.1 | Library | Core / API Library | Trikzon | LGPL-3.0-or-later | [Modrinth](https://modrinth.com/mod/ash-api) | An API that provides an abstraction layer between the three main Minecraft mod loaders (Fabric, Forge, and Quilt) |
| 7 | **AttributeFix** | 21.0.4 | Mod | QoL Gameplay | Darkhax | LGPL V2.1 | [Modrinth](https://modrinth.com/mod/attributefix) | Extends the maximum attribute ranges to allow for higher values |
| 8 | **Axes Are Weapons** | 1.7.3 | Mod | QoL Gameplay | Fourmisain | MIT | [Modrinth](https://modrinth.com/mod/axes-are-weapons) | Disables the increased durability loss in combat and enables Looting for axes Damage enchantments for axes will appear in the Enchanting Table too Check the options for more! |
| 9 | **Balm** | 7.3.9 | Library | Core / API Library | BlayTheNinth | All Rights Reserved | [Modrinth](https://modrinth.com/mod/balm) | Abstraction Layer (but not really)™ for Blay's multiplatform mods |
| 10 | **Beautify: Refabricated** | 1.2.0+1.20.1 | Mod | Building / Decoration | Suel_ki | MIT | [Modrinth](https://modrinth.com/mod/beautify-refabricated) | Beautify adds lots of vanilla-styled ways to spice up your builds with custom models that'll fit right in to your houses etc |
| 11 | **Bento Box** | 0.2.2+1.20 | Library | Core / API Library | Chai | LGPL-3.0 | [Modrinth](https://modrinth.com/mod/bento-box) | A library mod for Chai's mods |
| 12 | **Better Hanging Signs** | 4 | Datapack | QoL Gameplay | efeketket | MIT | [Modrinth](https://modrinth.com/mod/better-hanging-signs) | It will enable your hanging signs to hold items. Better than just text, isn't it? |
| 13 | **Better Mount HUD** | 1.2.2 | Mod | UI / HUD | Lortseam | GPL-3.0 | [Modrinth](https://modrinth.com/mod/better-mount-hud) | Improves the ingame HUD while riding a mount |
| 14 | **Better Statistics Screen** | 3.12.6+fabric-1.20.1 | Mod | UI / HUD | TheCSDev | LGPL-3.0 | [Modrinth](https://modrinth.com/mod/better-stats) | Improves the statistics screen and makes it more useful |
| 15 | **BetterF3** | 7.0.2 | Mod | UI / Menus | cominixo, TreyRuffy | MIT | [Modrinth](https://modrinth.com/mod/betterf3) | Replaces Minecraft's original debug HUD with a highly customizable, more human-readable HUD |
| 16 | **Bookshelf** | 20.2.13 | Library | Core / API Library | Darkhax | LGPL V2.1 | [Modrinth](https://modrinth.com/mod/bookshelf-lib) | A library for building other mods |
| 17 | **Bountiful** | 6.0.3+1.20.1 | Mod | Content: Exploration | Ejektaflex | GPL 3.0 | [Modrinth](https://modrinth.com/mod/bountiful) | Bountiful adds bounty boards to the world |
| 18 | **Cardinal Components API** | 5.2.2 | Library | Core / API Library | UpcraftLP, Pyrofab | MIT | [Modrinth](https://modrinth.com/mod/cardinal-components-api) | Attaching more data to various game objects |
| 19 | **Carry On** | 2.1.2.7 | Mod | QoL Gameplay | Tschipp, Purplicious_Cow, cy4n | GNU LGPLv3 | [Modrinth](https://modrinth.com/mod/carry-on) | Carry On is a simple mod that improves game interaction by allowing players to pick up, carry, and place single block Tile Entities using only their empty hands |
| 20 | **Chat Animation [Smooth Chat]** | 1.0.5 | Mod | UI / Menus | Ezzenix | CC0-1.0 | [Modrinth](https://modrinth.com/mod/chatanimation) | Adds animations to the chat |
| 21 | **Chunks fade in** | 1.0.7-1.20.1 | Mod | Rendering / Shaders | Koteinik | GPLv3 | [Modrinth](https://modrinth.com/mod/chunks-fade-in) | Adds bedrock-like chunk fade-in animation and chunk animations like in ChunkAnimator mod! |
| 22 | **Cloth Config API** | 11.1.136 | Library | Core / API Library | shedaniel | GNU LGPLv3 | [Modrinth](https://modrinth.com/mod/cloth-config) | An API for config screens |
| 23 | **Collective** | 7.87 | Library | Core / API Library | Rick South | All Rights Reserved | [Modrinth](https://modrinth.com/mod/collective) | Collective is a shared library with common code for all of Serilum's mods |
| 24 | **CompleteConfig** | 2.5.2 | Library | Core / API Library | Lortseam | Apache-2.0 | [Modrinth](https://modrinth.com/mod/completeconfig) | Configuration library |
| 25 | **Configured** | 1.3.1 | Mod | Pack Utility | Jack | MIT | [Modrinth](https://modrinth.com/mod/configured) | Take control over minecraft's features |
| 26 | **Connected Glass** | 1.1.12 | Mod | Building / Decoration | SuperMartijn642 | All rights reserved | [Modrinth](https://modrinth.com/mod/connected-glass) | Connected Glass adds new types of glass with connecting textures! |
| 27 | **Continue Button** | 1.2.2+1.20 | Mod | UI / Menus | umollu, mineblock11 | MIT | [Modrinth](https://modrinth.com/mod/continue) | Continue the last world or server you played from the title screen |
| 28 | **Controlling** | 12.0.2 | Mod | UI / Menus | Jaredlll08 | MIT | [Modrinth](https://modrinth.com/mod/controlling) | Adds the ability to search for keybinds using their name in the KeyBinding menu, this allows players to easily find a key binding in the menu |
| 29 | **Cristel Lib** | 1.1.5 | Library | Core / API Library | Cristelknight999 | CC BY-NC-ND 4.0 | [Modrinth](https://modrinth.com/mod/cristel-lib) | A Library mod for easy structure config and runtime datapacks |
| 30 | **Cubes Without Borders** | 3.0.0+mc1.20 | Mod | UI / Menus | Kir_Antipov | MIT | [Modrinth](https://modrinth.com/mod/cubes-without-borders) | Allows you to play Minecraft in a borderless fullscreen window |
| 31 | **Cut Through** | 8.0.2 | Mod | QoL Gameplay | Fuzs | MPL-2.0 | [Modrinth](https://modrinth.com/mod/cut-through) | Cleanly swing through transparent blocks like tall grass to hit mobs without breaking said block |
| 32 | **Dark Loading Screen** | 1.6.14 | Mod | UI / Menus | Neecko5b84 | LGPL-3.0-or-later | [Modrinth](https://modrinth.com/mod/dark-loading-screen) | Makes the loading screen darker In-game configuration requires Mod Menu and Cloth Config |
| 33 | **Default Options** | 18.0.1 | Mod | Pack Utility | BlayTheNinth | All Rights Reserved | [Modrinth](https://modrinth.com/mod/default-options) | A way for modpacks to ship a default (key) configuration without having to include an options.txt file. Also allows local options from any mod .cfg file |
| 34 | **Double Doors** | 5.9 | Mod | QoL Gameplay | Rick South | All Right Reserved | [Modrinth](https://modrinth.com/mod/double-doors) | Adds the ability for identical double doors, trapdoors and fence gates to be opened simultaneously via click or pressure plates and buttons |
| 35 | **Dungeons and Taverns** | 3.0.3.f | Datapack | World Generation | NovaWostra, Walls | LicenseRef-All-Rights-Reserved | [Modrinth](https://modrinth.com/mod/dungeons-and-taverns) | A Structure Datapack adding dungeons, taverns and other structures to find while you explore the world |
| 36 | **Dynamic Lights** | 1.8.3+mod | Mod | Rendering / Shaders | Tschipcraft | Custom | [Modrinth](https://modrinth.com/mod/dynamic-lights) | Supported entities and items will emit light by using the light block added in 21w13a. §lSupported Items:§r Torches, Lanterns, Campfires, Glowstone, Glowstone Dust, Magma Blocks, Blaze Rods, Blaze Pow |
| 37 | **Easy Shulker Boxes** | 8.0.2 | Mod | QoL Gameplay | Fuzs | MPL-2.0 | [Modrinth](https://modrinth.com/mod/easy-shulker-boxes) | Supercharge shulkes boxes, bundles and backpacks! Fully useable in your inventory with many intuitive interactions |
| 38 | **Effect Insights** | 8.0.2 | Mod | UI / HUD | Fuzs | MPL-2.0 | [Modrinth](https://modrinth.com/mod/effect-insights) | Find out what potion effects do without checking the wiki |
| 39 | **Elytra Slot** | 6.4.4+1.20.1 | Mod | QoL Gameplay | Illusive Soulworks | LGPL-3.0-or-later | [Modrinth](https://modrinth.com/mod/elytra-slot) | Adds an accessory slot for the elytra, so you can fly and wear chest armor at the same time |
| 40 | **[EMF] Entity Model Features** | 2.2.6 | Mod | Resource Pack Support | Traben | LGPL-3.0 | [Modrinth](https://modrinth.com/mod/entity-model-features) | This is an expansion of the ETF mod, it adds support for OptiFine format Custom Entity Model (CEM) resource packs. While still allowing you to disable this to use a different model mod :) |
| 41 | **Enchantment Descriptions** | 17.1.19 | Mod | UI / HUD | Darkhax | LGPL V2.1 | [Modrinth](https://modrinth.com/mod/enchantment-descriptions) | Adds descriptions of enchantments to their tooltip |
| 42 | **End Remastered** | 5.2.4 | Mod | Content: Exploration | jack_bagel Dev, maxmitchelson Dev, And Artist, gilvoisard Artist | CC0-1.0 | [Modrinth](https://modrinth.com/mod/endrem) | End Remastered aims to make your Minecraft experience more challenging by emphasizing the adventurous side of the game |
| 43 | **Entity Culling** | 1.7.1 | Mod | Performance | tr7zw | tr7zw Protective License | [Modrinth](https://modrinth.com/mod/entityculling) | This mod uses async path-tracing to hide Tiles/Entities that are not visible |
| 44 | **Essential** | 1.3.5.3 | Mod (container) | Utility / Social |  | LicenseRef-All-Rights-Reserved | [Modrinth](https://modrinth.com/mod/essential) | Enhance your Minecraft with one simple mod. Host worlds for free, chat with friends, and so much more! |
| 45 | **[ETF] Entity Texture Features** | 6.2.7 | Mod | Resource Pack Support | Traben | LGPL-3.0 | [Modrinth](https://modrinth.com/mod/entitytexturefeatures) | Adds support for resource-pack driven features for entity textures including some OptiFine features Supports OptiFine: - Random & Custom textures - Emissive textures With more features such as: - B |
| 46 | **Explorer's Compass** | 1.20.1-2.2.3-fabric | Mod | Content: Exploration | ChaosTheDude | CC BY-NC-SA 4.0 | [Modrinth](https://modrinth.com/mod/explorers-compass) | Search for and locate structures anywhere in the world |
| 47 | **Fabric API** | 0.92.2+1.20.1 | Library | Core / API Library | FabricMC | Apache-2.0 | [Modrinth](https://modrinth.com/mod/fabric-api) | Core API module providing key hooks and intercompatibility features |
| 48 | **Fabric Language Kotlin** | 1.12.3+kotlin.2.0.21 | Library | Core / API Library | FabricMC | Apache-2.0 | [Modrinth](https://modrinth.com/mod/fabric-language-kotlin) | Fabric language module for Kotlin |
| 49 | **FakerLib** | 0.1.4 | Library | Core / API Library | ShadowsOfFire (forge version), TheWinABagel | CC0-1.0 | [Modrinth](https://modrinth.com/mod/fakerlib) | Library mod for Zenith and co |
| 50 | **Forge Config API Port** | 8.0.0 | Library | Core / API Library | Fuzs | MPL-2.0 | [Modrinth](https://modrinth.com/mod/forge-config-api-port) | Forge's whole config system provided to the Fabric ecosystem. Designed for a multiloader architecture |
| 51 | **Fusion (Connected Textures)** | 1.1.1 | Mod | Building / Decoration | SuperMartijn642 | All rights reserved | [Modrinth](https://modrinth.com/mod/fusion-connected-textures) | Fusion allows resource packs to use additional texture and model types such as connected textures! |
| 52 | **Game Menu Remove GFARB** | 2.1.2 | Mod | UI / Menus | MORIMORI0317 | GNU LGPLv3 | [Modrinth](https://modrinth.com/mod/gamemenuremovegfarb) | This mod is a mod that removes the "Give Feedback" and "Report Bugs" buttons in the game menu. The ikisugi game menu mod |
| 53 | **Geophilic** | 3.1.4 | Mod | World Generation | bebebea_loste | ARR | [Modrinth](https://modrinth.com/mod/geophilic) | A subtle-ish overhaul of vanilla Overworld biomes |
| 54 | **Horseshoes** | 1.0.3 | Mod | Content: Utility | HyperPigeon | MIT | [Modrinth](https://modrinth.com/mod/horseshoes) | A mod that adds enchantable horseshoes to Minecraft |
| 55 | **Iceberg** | 1.1.25 | Library | Core / API Library | Grend | CC BY-NC-ND 4.0 | [Modrinth](https://modrinth.com/mod/iceberg) | A library containing events, helpers, and utilities to make modding easier |
| 56 | **iChunUtil** | 1.0.0 | Library | Core / API Library | iChun | GNU Lesser General Public License v3.0 | [Modrinth](https://modrinth.com/mod/ichunutil) | Shared library mod required by most of iChun's Mods |
| 57 | **ImmersiveThunder** | 1.20.1+1.2.2 | Mod | Rendering / Shaders | LeahPy | MIT | [Modrinth](https://modrinth.com/mod/immersivethunder) | Just a simple mod to use distance-based thunder sounds |
| 58 | **Indium** | 1.0.34+mc1.20.1 | Mod | Rendering / Shaders | comp500 | Apache-2.0 | [Modrinth](https://modrinth.com/mod/indium) | Sodium addon providing support for the Fabric Rendering API, based on Indigo |
| 59 | **Inventory Sorting** | 1.9.0-1.20 | Mod | UI / Menus | kyrptonaught | MIT | [Modrinth](https://modrinth.com/mod/inventory-sorting) | Quickly and easily sort inventorys |
| 60 | **Iris Shaders** | 1.7.5+mc1.20.1 | Mod | Rendering / Shaders | coderbot, IMS212, Justsnoopy30, FoundationGames | LGPL-3.0-only | [Modrinth](https://modrinth.com/mod/iris) | A modern shaders mod for Minecraft intended to be compatible with existing OptiFine shader packs |
| 61 | **Just Enough Items (JEI)** | 15.20.0.105 | Mod | Content: UI | mezz | The MIT License (MIT) | [Modrinth](https://modrinth.com/mod/jei) | JEI is an item and recipe viewing mod for Minecraft, built from the ground up for stability and performance |
| 62 | **Just Enough Professions (JEP)** | 3.0.1 | Mod | Content: UI | Mrbysco, ShyNieke | MIT | [Modrinth](https://modrinth.com/mod/just-enough-professions-jep) | Adds info about professions to JEI |
| 63 | **Just Enough Resources (JER)** | 1.4.0.247 | Mod | Content: UI | way2muchnoise | "Don't Be a Jerk" non-commercial care-free license | [Modrinth](https://modrinth.com/mod/just-enough-resources-jer) | Adds Resources and Mob Drops to JEI |
| 64 | **Kambrik** | 6.1.1+1.20.1 | Library | Core / API Library | Ejektaflex | GPL 3.0 | [Modrinth](https://modrinth.com/mod/kambrik) | A Light-weight Kotlin Library Mod! |
| 65 | **Lanterns Belong on Walls** | 1.6.1+1.20.1 | Mod | QoL Gameplay | ThePoultryMan | MIT | [Modrinth](https://modrinth.com/mod/lanterns-bow) | Lanterns Belong on Walls allows the placing of lanterns on walls |
| 66 | **Leaves Be Gone** | 8.0.0 | Mod | QoL Gameplay | Fuzs | MPL-2.0 | [Modrinth](https://modrinth.com/mod/leaves-be-gone) | Quick leaf decay from cutting down trees. Built for great performance and mod compat! |
| 67 | **Legendary Tooltips** | 1.4.5 | Mod | UI / HUD | Grend | CC BY-NC-ND 4.0 | [Modrinth](https://modrinth.com/mod/legendary-tooltips) | Gives rare items a fancy tooltip and adds additional tooltip configuration options |
| 68 | **Let Me Despawn** | 1.4.4 | Mod | Performance | frikinjay | LGPL-3.0 | [Modrinth](https://modrinth.com/mod/lmd) | Tweaks mob despawn rules to prevent accidental persistent mobs to increase performance |
| 69 | **Let Sleeping Dogs Lie** | 1.3.0 | Mod | QoL Gameplay | iChun | GNU Lesser General Public License v3.0 | [Modrinth](https://modrinth.com/mod/let-sleeping-dogs-lie) | Lets dogs lie |
| 70 | **Litematica** | 0.15.4 | Mod | Technical / Creative | masa | LGPLv3 | [Modrinth](https://modrinth.com/mod/litematica) | A modern schematic mod for LiteLoader, Rift, Fabric etc |
| 71 | **MaLiLib** | 0.16.3 | Mod | Technical / Creative | masa | LGPLv3 | [Modrinth](https://modrinth.com/mod/malilib) | A library mod required by masa's client-side mods |
| 72 | **Map Atlases** | 2.6.0 | Mod | Content: Utility | Pepperoni__Jabroni__ | GPL-3.0 | [Modrinth](https://modrinth.com/mod/map-atlases) | A vanilla-friendly mini-map/world-map mod using vanilla Maps! |
| 73 | **Max Health Fix** | 12.0.3 | Mod | QoL Gameplay | Darkhax | LGPL V2.1 | [Modrinth](https://modrinth.com/mod/max-health-fix) | Fixes the infamous MC-17876 bug. This bug would cause players with above 20 health to be reset when the restart the game |
| 74 | **Mod Menu** | 7.2.2 | Mod | UI / Menus | Prospector, haykam821, TerraformersMC | MIT | [Modrinth](https://modrinth.com/mod/modmenu) | Adds a mod menu to view the list of mods you have installed |
| 75 | **Model Gap Fix** | 1.15 | Mod | Performance | Mehvahdjukaar | GPL-3 | [Modrinth](https://modrinth.com/mod/modelfix) | Fixes those annoying gaps that appear in item and block models |
| 76 | **ModernFix** | 5.19.5+mc1.20.1 | Mod | Performance | embeddedt | LGPL-3.0 | [Modrinth](https://modrinth.com/mod/modernfix) | Egregious, yet effective performance improvements for modern Minecraft |
| 77 | **Moonlight Lib** | 1.20-2.13.25 | Library | Core / API Library | MehVahdJukaar | gplv3 | [Modrinth](https://modrinth.com/mod/moonlight) | Custom Villagers AI and Map Markers, First and third person item animations, dynamic assets and registration & more |
| 78 | **Mouse Tweaks** | 2.26 | Mod | UI / Menus | Ivan Molodetskikh (YaLTeR) | BSD-3-Clause | [Modrinth](https://modrinth.com/mod/mouse-tweaks) | A mod that enhances the inventory management by adding various additional functions to the usual mouse buttons |
| 79 | **Nature's Compass** | 1.20.1-2.2.3-fabric | Mod | Content: Exploration | ChaosTheDude | CC BY-NC-SA 4.0 | [Modrinth](https://modrinth.com/mod/natures-compass) | Search for a biome and get information about it |
| 80 | **Not Enough Animations** | 1.8.1 | Mod | Player Animations | tr7zw | tr7zw Protective License | [Modrinth](https://modrinth.com/mod/not-enough-animations) | Adding and improving animations in Third-Person |
| 81 | **oωo (owo-lib)** | 0.11.2+1.20 | Library | Core / API Library | glisco, BasiqueEvangelist, Noaaan | MIT | [Modrinth](https://modrinth.com/mod/owo-lib) | yes its bad i know thanks |
| 82 | **Particular ✨** | 1.1.1 | Mod | Rendering / Shaders | Chai | LGPL-3.0 | [Modrinth](https://modrinth.com/mod/particular) | Enhances Minecraft's ambience with hand-crafted visual effects like fireflies, falling leaves, and waterfall cascades |
| 83 | **Patchouli** | 1.20.1-84-FABRIC | Library | Core / API Library | Vazkii, williewillus | CC BY-NC-SA 3.0 | [Modrinth](https://modrinth.com/mod/patchouli) | Patchouli: Accessible, Data-Driven, Dependency-Free Documentation for Minecraft Modders and Pack Makers |
| 84 | **Paxi** | 1.20-Fabric-4.0 | Mod | Pack Utility | YUNGNICKYOUNG | LGPLv3 | [Modrinth](https://modrinth.com/mod/paxi) | Drag-and-drop your data packs and let Paxi do the rest! Global data packs made easy |
| 85 | **Pick Up Notifier** | 8.0.0 | Mod | QoL Gameplay | Fuzs | MPL-2.0 | [Modrinth](https://modrinth.com/mod/pick-up-notifier) | Be notified about all the things you've just collected |
| 86 | **Polymorph** | 0.49.7+1.20.1 | Mod | QoL Gameplay | Illusive Soulworks | LGPL-3.0-or-later | [Modrinth](https://modrinth.com/mod/polymorph) | No more recipe conflicts! Adds an option to choose the crafting result if more than one is available |
| 87 | **Prism** | 1.0.5 | Library | Core / API Library | Grend | CC BY-NC-ND 4.0 | [Modrinth](https://modrinth.com/mod/prism-lib) | A library all about color! Provides lots of color-related functionality for dependent mods |
| 88 | **Puzzles Lib** | 8.1.24 | Library | Core / API Library | Fuzs | MPL-2.0 | [Modrinth](https://modrinth.com/mod/puzzles-lib) | Why's it called Puzzles you ask? That's the puzzle! |
| 89 | **Realms Button Remover** | 2.0.5 | Mod | UI / Menus | blucobalt | LGPL-2.1 | [Modrinth](https://modrinth.com/mod/realms-button-remover) | Removes the realms button from the title screen |
| 90 | **Replanting Crops** | 5.4 | Mod | QoL Gameplay | Rick South | All Right Reserved | [Modrinth](https://modrinth.com/mod/replanting-crops) | Automatically replants/replaces/reseeds crops harvested with seeds from drops, negated by holding the sneak button |
| 91 | **Rusticated** | 3.0.1-fabric | Mod | Building / Decoration | cScotPlay, cadaverous-eris (Original Mastermind) | MIT | [CurseForge](https://www.curseforge.com/minecraft/mc-mods/rusticated) | Rusticated is an updated and reinvigorated mod based on our beloved, Rustic |
| 92 | **Searchables** | 1.0.3 | Library | Core / API Library | Jaredlll08 | MIT | [Modrinth](https://modrinth.com/mod/searchables) | A library mod to facilitate adding search bars with auto complete and search types |
| 93 | **Server Sleep** | 1.0.0 (datapack) | Datapack | Content: Utility | Aninuscsalas | MIT | [Modrinth](https://modrinth.com/mod/serversleep) | Changes playersSleepingPercentage to 50% |
| 94 | **Smooth Scrolling Refurbished** | 1.1.2 | Mod | UI / Menus | JustAlittleWolf | MIT | [Modrinth](https://modrinth.com/mod/smooth-scrolling-refurbished) | Changes most scrollbars in the game to scroll smoothly |
| 95 | **Smooth Swapping** | 0.9.3.1 | Mod | UI / Menus | Schauweg | GNU LGPL 3.0 | [Modrinth](https://modrinth.com/mod/smooth-swapping) | Moves the items in an inventory smoothly instead of instantly |
| 96 | **Sodium** | 0.5.11+mc1.20.1 | Mod | Performance | @jellysquid3 | LGPL-3.0-only | [Modrinth](https://modrinth.com/mod/sodium) | Sodium is a free and open-source optimization mod for Minecraft which improves frame rates and reduces lag spikes |
| 97 | **Sound Physics Remastered** | 1.20.1-1.4.5 | Mod | Rendering / Shaders | Sonic Ether, vlad2305m, Max Henkel, Saint | GPL | [Modrinth](https://modrinth.com/mod/sound-physics-remastered) | Provides realistic sound attenuation, reverberation, and absorption through blocks |
| 98 | **Sparse Structures** | 2.2.0 | Mod | World Generation | MaxenceDC | MIT | [Modrinth](https://modrinth.com/mod/sparsestructures) | Makes all structures more spread out. Configurable. If you want to support me, you can use code MAX at BisectHosting for 25% off! |
| 99 | **Statement** | 4.2.9+1.14.4-1.20.4 | Library | Core / API Library | Virtuoel | MIT | [Modrinth](https://modrinth.com/mod/statement) | Library to assist with adding properties to existing block states |
| 100 | **Status Effect Bars** | 1.0.3 | Mod | UI / HUD | Neecko5b84 | LGPL-3.0-or-later | [Modrinth](https://modrinth.com/mod/status-effect-bars) | Adds small customizable bars to the status effects overlay and in the inventory to show the remaining duration of effects |
| 101 | **Stoneworks** | 8.0.0 | Mod | Building / Decoration | Fuzs | MPL-2.0 | [Modrinth](https://modrinth.com/mod/stoneworks) | Vanilla stone types in plenty of variations for all your building needs |
| 102 | **SuperMartijn642's Core Lib** | 1.1.17+a | Library | Core / API Library | SuperMartijn642 | All rights reserved | [Modrinth](https://modrinth.com/mod/supermartijn642s-core-lib) | SuperMartijn642's Core Lib adds lots of basic implementations for guis that allow for similar code between Minecraft 1.12, 1.14, 1.15, and 1.16! |
| 103 | **TCDCommons API** | 3.12.3+fabric-1.20.1 | Library | Core / API Library | TheCSDev | LGPL-3.0 | [Modrinth](https://modrinth.com/mod/tcdcommons) | My personal API library for my mods. It aims to improve performance by avoiding rewriting the same code, and to speed up the mod development process |
| 104 | **Tiny Item Animations** | 1.20-1.1 | Mod | Player Animations | Trivaxy | MIT | [Modrinth](https://modrinth.com/mod/tiny-item-animations) | Adds a cute little animation when picking up items with your mouse |
| 105 | **Tips** | 12.1.8 | Mod | UI / HUD | Darkhax | LGPL V2.1 | [Modrinth](https://modrinth.com/mod/tips) | Adds useful tips to various loading screens in game |
| 106 | **Towns and Towers** | 1.12 | Mod | World Generation | Kubek and Biban_Auriu, Cristelknight999 | CC BY-NC-SA 4.0 | [Modrinth](https://modrinth.com/mod/towns-and-towers) | Spice up your world with new villages, pillager outposts, and even new ships! |
| 107 | **Traveler's Backpack** | 9.1.18 | Mod | Content: Utility | Tiviacz1337 | GPL v3 | [Modrinth](https://modrinth.com/mod/travelersbackpack) | Unique and upgradeable backpacks with customisation, Trinkets integration and more! |
| 108 | **TrimsEffects** | 1.3.5 | Mod | QoL Gameplay | luavixen, Lupin | UNLICENSED | [Modrinth](https://modrinth.com/mod/trimseffects) | Makes armor trims grant special effects |
| 109 | **Trinkets** | 3.7.2 | Library | Core / API Library | Emi, C4 | MIT | [Modrinth](https://modrinth.com/mod/trinkets) | Adds a data-driven accessory system to Minecraft |
| 110 | **Trowel** | 1.3.0-1.20 | Mod | QoL Gameplay | TheEnderCore, Astra | MIT | [Modrinth](https://modrinth.com/mod/trowel) | A fabric port of Quarks Trowel item |
| 111 | **True Ending - Ender Dragon Overhaul** | 1-v1.1.0c | Datapack | World Generation | limesplatus | LicenseRef-Custom | [Modrinth](https://modrinth.com/mod/true-ending) | A dramatic overhaul to the Ender Dragon boss fight. New attacks and elegant particle animation come together to form a more satisfying ending |
| 112 | **Variant Vanilla Blocks** | 1.3.8 | Mod | Building / Decoration | Xanthian | MIT | [Modrinth](https://modrinth.com/mod/variant-vanilla-blocks) | Vanilla blocks recreated in all vanilla wood types |
| 113 | **Villager Names** | 8.1 | Mod | QoL Gameplay | Rick South | All Right Reserved | [Modrinth](https://modrinth.com/mod/villager-names-serilum) | Gives all villagers and villager-like entities their own name |
| 114 | **Visuality** | 0.7.1+1.20 | Mod | Rendering / Shaders | PinkGoosik | MIT | [Modrinth](https://modrinth.com/mod/visuality) | Little visual improvements by adding a bunch of new particles |
| 115 | **Wandering Collector** | 1.2.1+mc1.20-pre5 | Mod | QoL Gameplay | Siphalor | Apache-2.0 | [Modrinth](https://modrinth.com/mod/wandering-collector) | Wandering Traders trade lost items back to the player. The initial idea for this feature was suggested by SimplySarc in one of his videos |
| 116 | **Waystones** | 14.1.6 | Mod | Content: Utility | BlayTheNinth | All Rights Reserved | [Modrinth](https://modrinth.com/mod/waystones) | Teleport back to activated waystones. For Survival, Adventure or Servers |
| 117 | **WITS (What Is This Structure?)** | 1.1.0+1.20.1-fabric | Mod | Content: Exploration | TelepathicGrunt | MIT License | [Modrinth](https://modrinth.com/mod/wits) | Use `\wits` command to get registry name of all structures where you are standing |
| 118 | **YUNG's API** | 1.20-Fabric-4.0.6 | Library | Core / API Library | YUNGNICKYOUNG | LGPLv3 | [Modrinth](https://modrinth.com/mod/yungs-api) | API Library for YUNG's minecraft mods |
| 119 | **YUNG's Better Desert Temples** | 1.20-Fabric-3.0.3 | Mod | World Generation | YUNGNICKYOUNG, Tera | LGPLv3 | [Modrinth](https://modrinth.com/mod/yungs-better-desert-temples) | A complete redesign of Minecraft's desert temples! |
| 120 | **YUNG's Better Dungeons** | 1.20-Fabric-4.0.4 | Mod | World Generation | YUNGNICKYOUNG, Acarii | LGPLv3 | [Modrinth](https://modrinth.com/mod/yungs-better-dungeons) | A complete redesign of Minecraft's dungeons |
| 121 | **YUNG's Better End Island** | 1.20-Fabric-2.0.6 | Mod | World Generation | YUNGNICKYOUNG, Acarii | LGPLv3 | [Modrinth](https://modrinth.com/mod/yungs-better-end-island) | A complete redesign of the End island, making the Ender Dragon fight much more fun and interesting! |
| 122 | **YUNG's Better Jungle Temples** | 1.20-Fabric-2.0.5 | Mod | World Generation | YUNGNICKYOUNG, Tera | LGPLv3 | [Modrinth](https://modrinth.com/mod/yungs-better-jungle-temples) | A complete redesign of Minecraft's Jungle Temples! |
| 123 | **YUNG's Better Mineshafts** | 1.20-Fabric-4.0.4 | Mod | World Generation | YUNGNICKYOUNG | LGPLv3 | [Modrinth](https://modrinth.com/mod/yungs-better-mineshafts) | The long-awaited and much-needed abandoned mineshaft overhaul! |
| 124 | **YUNG's Better Nether Fortresses** | 1.20-Fabric-2.0.6 | Mod | World Generation | YUNGNICKYOUNG, Acarii | LGPLv3 | [Modrinth](https://modrinth.com/mod/yungs-better-nether-fortresses) | A complete redesign of Minecraft's Nether Fortresses! |
| 125 | **YUNG's Better Ocean Monuments** | 1.20-Fabric-3.0.4 | Mod | World Generation | YUNGNICKYOUNG, Tera | LGPLv3 | [Modrinth](https://modrinth.com/mod/yungs-better-ocean-monuments) | A complete redesign of Minecraft's ocean monuments! |
| 126 | **YUNG's Better Strongholds** | 1.20-Fabric-4.0.3 | Mod | World Generation | YUNGNICKYOUNG, Acarii | LGPLv3 | [Modrinth](https://modrinth.com/mod/yungs-better-strongholds) | A complete redesign of Minecraft's strongholds! |
| 127 | **YUNG's Better Witch Huts** | 1.20-Fabric-3.0.3 | Mod | World Generation | YUNGNICKYOUNG, Acarii | LGPLv3 | [Modrinth](https://modrinth.com/mod/yungs-better-witch-huts) | Adds new and improved witch huts to swamps! |
| 128 | **YUNG's Extras** | 1.20-Fabric-4.0.3 | Mod | World Generation | YUNGNICKYOUNG, Acarii | LGPLv3 | [Modrinth](https://modrinth.com/mod/yungs-extras) | Extra structures and vanilla+ content added throughout the game! |
| 129 | **Zenith** | 1.2.3 | Mod | Content: Enchanting / RPG | ShadowsOfFire (Forge), Safro (original port), TheWinABagel | MIT License | [Modrinth](https://modrinth.com/mod/zenith) | Unofficial Fabric port of Apotheosis |
| 130 | **Zenith Attributes** | 0.2.7 | Mod | Content: Enchanting / RPG | ShadowsOfFire (Forge), TheWinABagel (Fabric Port) | CC0-1.0 | [Modrinth](https://modrinth.com/mod/zenith-attributes) | Adds attributes, needed for Zenith |

---

## 5. Roster breakdown

### By role (130 jars)

| Role group | Count | Notable members |
|---|---:|---|
| Core / API Libraries | 29 | Fabric API, Fabric Language Kotlin, Architectury, Balm, Trinkets, Cardinal Components, Cloth Config, Bookshelf, Puzzles Lib, Moonlight, oωo, Kambrik, Collective… |
| QoL Gameplay | 20 | Carry On, Easy Shulker Boxes, Traveler's Backpack, Waystones, Double Doors, Replanting Crops, Cut Through, Elytra Slot, Axes Are Weapons, AttributeFix, MaxHealthFix |
| World Generation & Structures | 15 | 9× YUNG's mods, Towns and Towers, Dungeons and Taverns, Geophilic, Sparse Structures, True Ending |
| UI / Menus | 13 | BetterF3, Mod Menu, Controlling, Dark Loading Screen, Game Menu Remove GFARB, Realms Button Remover, Continue, Mouse Tweaks, Inventory Sorting, Smooth Scrolling, Chat Animation, Smooth Swapping, Cubes Without Borders |
| UI / HUD & info | 8 | AppleSkin, Better Mount HUD, Status Effect Bars, Tips, Better Statistics Screen, Effect Descriptions, Enchantment Descriptions, Legendary Tooltips |
| Rendering / Shaders | 8 | Iris, Indium, Dynamic Lights, Sound Physics Remastered, Visuality, particular, Immersive Thunder, Chunks Fade In |
| Performance | 5 | Sodium, ModernFix, EntityCulling, Model Gap Fix, Let Me Despawn |
| Content: Exploration | 6 | Artifacts, End Remastered, Bountiful, Explorer's Compass, Nature's Compass, WITS |
| Building / Decoration | 6 | Stoneworks, Rusticated, Beautify, Connected Glass, Fusion, Variant Vanilla Blocks |
| Content: Utility | 5 | Waystones, Traveler's Backpack, Map Atlases, Horseshoes, Server Sleep |
| Content: UI (JEI family) | 3 | JEI, Just Enough Resources, Just Enough Professions |
| Pack Utility / config | 3 | Default Options, Paxi, Configured |
| Core tech / creative tools | 2 | Litematica + MaLiLib |
| Player animations | 2 | Not Enough Animations, Tiny Item Animations |
| Resource-pack support | 2 | Entity Model Features, Entity Texture Features |
| Enchanting / RPG | 2 | Zenith, Zenith Attributes |
| Utility / Social | 1 | Essential |

### By platform & licensing

- **Platform:** 129 mods from Modrinth CDN (pinned SHA-512), 1 from CurseForge (Rusticated, pinned SHA-1, file 4802419).
- **License mix** (from jar metadata): MIT/LGPL/MPL/Apache/GPL permissive family ≈ 95%; the balanced exceptions are Attribution-NonCommercial-NoDerivatives (the four Grend mods (Advancement Plaques, Iceberg, Legendary Tooltips, Prism)), CC-BY-NC-SA (Explorer's/Nature's Compass, Patchouli, Towns and Towers), and the fully proprietary **Essential** (ARR) and a few `All Rights Reserved` libraries (Balm & TwelveIterations mods, Collective/Serilum mods, SuperMartijn642's Core Lib — all permissive-in-practice but formally All-Rights-Reserved).

### Library dependency map (who needs whom)

Useful when pruning or updating — the load-bearing library wall:

- **Fabric API** → most content mods (container of ~87 modules)
- **Fabric Language Kotlin** → Kambrik, Trowel (and, transitively, Bountiful)
- **Architectury** → Artifacts (it is the multiplatform glue for Artifacts)
- **Trinkets + Cardinal Components** → Artifacts, Elytra Slot, Traveler's Backpack (accessory slots)
- **Balm + Almanac** → Waystones, Default Options (TwelveIterations) and frikinjay mods
- **Bookshelf + Collective** → Darkhax/Serilum mod families (Enchantment Descriptions, Tips, AttributeFix, Villager Names, Double Doors, Replanting Crops)
- **Cloth Config** → Axes Are Weapons, all YUNG's Better-X, Kambrik mods
- **Puzzles Lib + Forge Config API Port** → Fuzs's suite (Cut Through, Easy Shulker Boxes, Effect Descriptions, Leaves Be Gone, Pick Up Notifier, Stoneworks)
- **Moonlight** → ⚠ *nothing in the pack actually depends on it* — it is an orphan library left over from a mod that was removed; a safe prune candidate (the "Moonlight Mods Dynamic Assets" built-in resource pack enabled in `options.txt` comes from it alone)
- **oωo + Sushi Bar** → particular, Visuality
- **FakerLib** → Zenith + Zenith Attributes (the Fabric re-implementation of Placebo)
- **Statement** → Lanterns Belong on Walls (adds "on wall" states to lanterns)
- **Searchables + Controlling** → keybind search UI
- **JEP/JER/Just Enough Professions** → JEI addends (JEI itself is required)

---

## 6. Resource packs & shaders shipped with the instance

| File | Type | Author / details |
|---|---|---|
| `FreshAnimations_v1.9.zip` | Resource pack (1.9 **beta**, MC formats 15–30) | FreshLX — animated mobs/entities; drives the need for **EMF + ETF** (included) and plays nicely with Iris |
| `Stay_True_1.21.zip` | Resource pack (format 34) | HaiMcFly — vanilla-faithful texture rework (though targeted at 1.21 formats; installed but **not** in `options.txt` — currently only FreshAnimations is active) |
| `ComplementaryReimagined_r5.1.1.zip` | Shader pack | Complementary's "Reimagined" branch — the flagship Iris shader of the era; settings snapshot in the `.txt` alongside it |
| — | Built-in resource packs enabled | `vanilla`, `fabric`, `Moonlight Mods Dynamic Assets`, `file/FreshAnimations_v1.9.zip` |

Client settings (`options.txt`): vsync on, render distance **12 chunks**, max FPS 120, GUI scale auto, mipmap 4, gamma 0.5, music volume ~11%, particles "all", smooth lighting on — a deliberately modest/vanilla-flavored performance profile.

---

## 7. The pack's custom progression: "The 16 Eyes" (End Remastered)

`instance.cfg` contains a personal progression note listing all sixteen Eyes of **End Remastered (`fabric-end-remastered-5.2.4.jar`)**, each found/crafted through a completely different vanilla-adjacent activity — the mod's signature mechanic, which gates the End portal behind a world tour instead of a blaze-powder farm:

| # | Eye | Source |
|---|---|---|
| 1 | Old Eye | Desert Pyramids |
| 2 | Nether Eye | Nether Fortresses |
| 3 | Cold Eye | Igloos |
| 4 | Rogue Eye | Jungle Pyramids |
| 5 | Black Eye | Buried Chests (treasure) |
| 6 | Magical Eye | Dropped by Evokers |
| 7 | Lost Eye | Mineshafts |
| 8 | Corrupted Eye | Pillager Outposts |
| 9 | Wither Eye | Dropped by The Wither |
| 10 | Guardian Eye | Killing the Elder Guardian |
| 11 | Witch Eye | Crafted with a Witch Pupil |
| 12 | Cursed Eye | Bastion Remnant treasure chests |
| 13 | Exotic Eye | Crafted from aquatic items |
| 14 | Evil Eye | Purchased from a Master-level Cleric |
| 15 | Undead Eye | Crafted with an Undead Soul |
| 16 | Cryptic Eye | Small chance when enchanting |

(End Remastered requires **12** unique eyes to fill a portal. The redone End section is reinforced two more times by **True Ending: Ender Dragon Overhaul** and **YUNG's Better End Island** — a three-layer End overhaul.)

---

## 8. Worlds & usage history

- **Cappuccino** — the main survival world (created ~2024-11-15; most active session data, advancements and stats through 2024-11-17).
- **Milk and cookies** — secondary world (~2024-11-18).
- **Flat test world** — created 2024-11-18, last touched 2024-11-28 (superflat testing/config verification).
- **Playtime:** ≈ 88 hours of total playtime; mods installed en masse 2024-11-13; instance still being launched as of **2026-10-13** (`logs/latest.log`).
- **Creative tooling:** two Litematica schematics saved in `schematics/` ("House_blueprint", "Mesa_house"), snapshotting the building phase of the project.

---

## 9. Observations, caveats & update posture

1. **Frozen-in-amber snapshot.** Core mods date from Nov/Dec 2024 (Sodium 0.5.11, Iris 1.7.5, Fabric API 0.92.2, Fabric Loader 0.16.5 — all final 1.20.1-era builds). Nothing is broken, but as of Oct 2026 these are 1.5–2 years old; 1.20.1 upstream patch releases and the 1.21.x/1.21.4-1.21.8 ecosystem have long moved on. Updating is possible within 1.20.1 (newer Sodium/Iris 1.20.1 builds exist), but any such update should be done via the packwiz index (hash-pinned), not by dropping loose jars in.
2. **The stray jar.** `sparsestructures` is not in the packwiz index (see §3). Re-exporting/updating the pack through packwiz would silently drop it — add an index entry for `qwvI41y9`.
3. **Server/multiplayer.** Sodium, Iris, Indium, EntityCulling, ModernFix, etc. are **client-side** mods — joining a vanilla 1.20.1 server is fine. But world-generation mods (all YUNG's, Towns and Towers, Geophilic, Dungeons and Taverns, True Ending, End Remastered, Sparse Structures) change terrain/structure generation, so **new worlds and shared servers must run the identical pack**; existing generated worlds remain compatible but won't backfill new structures. `Server Sleep` ships as a datapack needing server installation.
4. **Essential** ships a proprietary container (`essential-container` 1.0.0 + embedded loader 1.2.3) that is ARR-licensed and client-only — it pulls in friends/hosting services and can be removed freely if the QoL/social features are unwanted (note it accounts for ~54% of the pack's on-disk size, 54 MB of 163 MB).
5. **Stay True is inactive.** It targets pack format 34 (1.21+) and is not enabled in `options.txt`; Fresh Animations (formats 15–30, covering 1.20.1) is the active look. Stay True could be re-enabled only after format adjustment, and it's incompatible with Fresh Animations' entity animation approach — pick one.
6. **Distinctive pairing worth preserving on updates:** Zenith's deep enchanting (gems & affixes) sits on top of Enchantment Descriptions + Legendary Tooltips, and the 16-Eye End gate sits next to the YUNG structures that make hunting the eyes interesting (fortresses, temples, outposts, bastions all redesigned) — the pack's gameplay spine.

---

## 10. Source appendix — files used to compile this report

```
instance.cfg                     instance settings, Java pin, progression notes, playtime
mmc-pack.json                    component graph: MC 1.20.1, Fabric 0.16.5, LWJGL 3.3.1
.minecraft/mods/*.jar           130 mod jars (fabric.mod.json metadata extracted from each)
.minecraft/mods/.index/*.pw.toml packwiz pins: exact version, URL, hash, Modrinth/CF IDs
.minecraft/logs/latest.log       live launch manifest: "Loading 267 mods"
.minecraft/options.txt           client settings, active resource packs
.resourcepacks/, shaderpacks/    Fresh Animations v1.9, Stay True 1.21, Complementary Reimagined r5.1.1
saves/, schematics/, screenshots/ worlds & creative artifacts
api.modrinth.com                 live project metadata (slugs, categories, side support, licenses)
```

*Every one of the 130 entries above was verified against its on-disk JAR and its official project page: 129 Modrinth projects (128 hash-pinned in the packwiz index + the manually added Sparse Structures) and 1 CurseForge project.*
