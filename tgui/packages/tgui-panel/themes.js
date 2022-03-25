/**
 * @file
 * @copyright 2020 Aleksej Komarov
 * @license MIT
 */

export const THEMES = ['RobCo', 'Mojave'];

const COLOR_GREEN_BG = '#01331a';
const COLOR_GREEN_BG_DARKER = '#000000';
const COLOR_GREEN_TEXT = '#4AEF98';
const COLOR_ORANGE_BG = '#322701';
const COLOR_ORANGE_BG_DARKER = '#170d03';
const COLOR_ORANGE_TEXT = '#deb624';

let setClientThemeTimer = null;

/**
 * Darkmode preference, originally by Kmc2000.
 *
 * This lets you switch client themes by using winset.
 *
 * If you change ANYTHING in interface/skin.dmf you need to change it here.
 *
 * There's no way round it. We're essentially changing the skin by hand.
 * It's painful but it works, and is the way Lummox suggested.
 */
export const setClientTheme = (name) => {
  // Transmit once for fast updates and again in a little while in case we won
  // the race against statbrowser init.
  clearInterval(setClientThemeTimer);
  Byond.command(`.output statbrowser:set_theme ${name}`);
  setClientThemeTimer = setTimeout(() => {
    Byond.command(`.output statbrowser:set_theme ${name}`);
  }, 1500);

  if (name === 'RobCo') {
    return Byond.winset({
      // Main windows
      'infowindow.background-color': COLOR_GREEN_BG,
      'infowindow.text-color': COLOR_GREEN_TEXT,
      'info.background-color': COLOR_GREEN_BG,
      'info.text-color': COLOR_GREEN_TEXT,
      'browseroutput.background-color': COLOR_GREEN_BG,
      'browseroutput.text-color': COLOR_GREEN_TEXT,
      'outputwindow.background-color': COLOR_GREEN_BG,
      'outputwindow.text-color': COLOR_GREEN_TEXT,
      'mainwindow.background-color': COLOR_GREEN_BG,
      'split.background-color': COLOR_GREEN_BG,
      // Buttons
      'changelog.background-color': COLOR_GREEN_BG,
      'changelog.text-color': COLOR_GREEN_TEXT,
      'discord.background-color': COLOR_GREEN_BG,
      'discord.text-color': COLOR_GREEN_TEXT,
      'rules.background-color': COLOR_GREEN_BG,
      'rules.text-color': COLOR_GREEN_TEXT,
      'wiki.background-color': COLOR_GREEN_BG,
      'wiki.text-color': COLOR_GREEN_TEXT,
      'forum.background-color': COLOR_GREEN_BG,
      'forum.text-color': COLOR_GREEN_TEXT,
      'github.background-color': COLOR_GREEN_BG,
      'github.text-color': COLOR_GREEN_TEXT,
      'webmap.background-color': COLOR_GREEN_BG,
      'webmap.text-color': COLOR_GREEN_TEXT,
      // Status and verb tabs
      'output.background-color': COLOR_GREEN_BG_DARKER,
      'output.text-color': COLOR_GREEN_TEXT,
      'statwindow.background-color': COLOR_GREEN_BG_DARKER,
      'statwindow.text-color': COLOR_GREEN_TEXT,
      'stat.background-color': COLOR_GREEN_BG_DARKER,
      'stat.tab-background-color': COLOR_GREEN_BG,
      'stat.text-color': COLOR_GREEN_TEXT,
      'stat.tab-text-color': COLOR_GREEN_TEXT,
      'stat.prefix-color': COLOR_GREEN_TEXT,
      'stat.suffix-color': COLOR_GREEN_TEXT,
      // Say, OOC, me Buttons etc.
      'saybutton.background-color': COLOR_GREEN_BG,
      'saybutton.text-color': COLOR_GREEN_TEXT,
      'oocbutton.background-color': COLOR_GREEN_BG,
      'oocbutton.text-color': COLOR_GREEN_TEXT,
      'mebutton.background-color': COLOR_GREEN_BG,
      'mebutton.text-color': COLOR_GREEN_TEXT,
      'asset_cache_browser.background-color': COLOR_GREEN_BG,
      'asset_cache_browser.text-color': COLOR_GREEN_TEXT,
      'tooltip.background-color': COLOR_GREEN_BG,
      'tooltip.text-color': COLOR_GREEN_TEXT,
    });
  }
  if (name === 'Mojave') {
    Byond.winset({
      // Main windows
      'infowindow.background-color': COLOR_ORANGE_BG,
      'infowindow.text-color': COLOR_ORANGE_TEXT,
      'info.background-color': COLOR_ORANGE_BG,
      'info.text-color': COLOR_ORANGE_TEXT,
      'browseroutput.background-color': COLOR_ORANGE_BG,
      'browseroutput.text-color': COLOR_ORANGE_TEXT,
      'outputwindow.background-color': COLOR_ORANGE_BG,
      'outputwindow.text-color': COLOR_ORANGE_TEXT,
      'mainwindow.background-color': COLOR_ORANGE_BG,
      'split.background-color': COLOR_ORANGE_BG,
      // Buttons
      'changelog.background-color': COLOR_ORANGE_BG,
      'changelog.text-color': COLOR_ORANGE_TEXT,
      'discord.background-color': COLOR_ORANGE_BG,
      'discord.text-color': COLOR_ORANGE_TEXT,
      'rules.background-color': COLOR_ORANGE_BG,
      'rules.text-color': COLOR_ORANGE_TEXT,
      'wiki.background-color': COLOR_ORANGE_BG,
      'wiki.text-color': COLOR_ORANGE_TEXT,
      'forum.background-color': COLOR_ORANGE_BG,
      'forum.text-color': COLOR_ORANGE_TEXT,
      'github.background-color': COLOR_ORANGE_BG,
      'github.text-color': COLOR_ORANGE_TEXT,
      'webmap.background-color': COLOR_ORANGE_BG,
      'webmap.text-color': COLOR_ORANGE_TEXT,
      // Status and verb tabs
      'output.background-color': COLOR_ORANGE_BG_DARKER,
      'output.text-color': COLOR_ORANGE_TEXT,
      'statwindow.background-color': COLOR_ORANGE_BG_DARKER,
      'statwindow.text-color': COLOR_ORANGE_TEXT,
      'stat.background-color': COLOR_ORANGE_BG_DARKER,
      'stat.tab-background-color': COLOR_ORANGE_BG,
      'stat.text-color': COLOR_ORANGE_TEXT,
      'stat.tab-text-color': COLOR_ORANGE_TEXT,
      'stat.prefix-color': COLOR_ORANGE_TEXT,
      'stat.suffix-color': COLOR_ORANGE_TEXT,
      // Say, OOC, me Buttons etc.
      'saybutton.background-color': COLOR_ORANGE_BG,
      'saybutton.text-color': COLOR_ORANGE_TEXT,
      'oocbutton.background-color': COLOR_ORANGE_BG,
      'oocbutton.text-color': COLOR_ORANGE_TEXT,
      'mebutton.background-color': COLOR_ORANGE_BG,
      'mebutton.text-color': COLOR_ORANGE_TEXT,
      'asset_cache_browser.background-color': COLOR_ORANGE_BG,
      'asset_cache_browser.text-color': COLOR_ORANGE_TEXT,
      'tooltip.background-color': COLOR_ORANGE_BG,
      'tooltip.text-color': COLOR_ORANGE_TEXT,
    });
  }
};
