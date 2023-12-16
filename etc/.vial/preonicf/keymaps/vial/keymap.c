 /* Copyright HarshitGoel96 2020
  * With permission from mattdibi, the original maintainer of the Redox hardware.
  *
  * This program is free software: you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
  * the Free Software Foundation, either version 2 of the License, or
  * (at your option) any later version.
  *
  * This program is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
  *
  * You should have received a copy of the GNU General Public License
  * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
#include QMK_KEYBOARD_H

// Each layer gets a name for readability, which is then used in the keymap matrix below.
// The underscores don't mean anything - you can have a layer called STUFF or any other name.
// Layer names don't all need to be of the same length, obviously, and you can also skip them
// entirely and just use numbers.



const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {

  [0] = LAYOUT(
        KC_NO, KC_NO, KC_NO, KC_NO,  KC_NO,  KC_NO,             KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO,
        KC_NO, KC_NO, KC_NO, KC_NO,  KC_NO,  KC_NO,             KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO,
        KC_NO, KC_NO, KC_NO, KC_NO,  KC_NO,  KC_NO,             KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO,
        KC_NO, KC_NO, KC_NO, KC_NO,  KC_NO,  KC_NO,             KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO,
        KC_NO, KC_NO, KC_NO, KC_NO,  KC_NO,  KC_NO,             KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO),
  [1] = LAYOUT(
        KC_NO, KC_NO, KC_NO, KC_NO,  KC_NO,  KC_NO,             KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO,
        KC_NO, KC_NO, KC_NO, KC_NO,  KC_NO,  KC_NO,             KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO,
        KC_NO, KC_NO, KC_NO, KC_NO,  KC_NO,  KC_NO,             KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO,
        KC_NO, KC_NO, KC_NO, KC_NO,  KC_NO,  KC_NO,             KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO,
        KC_NO, KC_NO, KC_NO, KC_NO,  KC_NO,  KC_NO,             KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO),
  [2] = LAYOUT(
        KC_NO, KC_NO, KC_NO, KC_NO,  KC_NO,  KC_NO,             KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO,
        KC_NO, KC_NO, KC_NO, KC_NO,  KC_NO,  KC_NO,             KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO,
        KC_NO, KC_NO, KC_NO, KC_NO,  KC_NO,  KC_NO,             KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO,
        KC_NO, KC_NO, KC_NO, KC_NO,  KC_NO,  KC_NO,             KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO,
        KC_NO, KC_NO, KC_NO, KC_NO,  KC_NO,  KC_NO,             KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO),
  [3] = LAYOUT(
        KC_NO, KC_NO, KC_NO, KC_NO,  KC_NO,  KC_NO,             KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO,
        KC_NO, KC_NO, KC_NO, KC_NO,  KC_NO,  KC_NO,             KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO,
        KC_NO, KC_NO, KC_NO, KC_NO,  KC_NO,  KC_NO,             KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO,
        KC_NO, KC_NO, KC_NO, KC_NO,  KC_NO,  KC_NO,             KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO,
        KC_NO, KC_NO, KC_NO, KC_NO,  KC_NO,  KC_NO,             KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO),
  [4] = LAYOUT(
        KC_NO, KC_NO, KC_NO, KC_NO,  KC_NO,  KC_NO,             KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO,
        KC_NO, KC_NO, KC_NO, KC_NO,  KC_NO,  KC_NO,             KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO,
        KC_NO, KC_NO, KC_NO, KC_NO,  KC_NO,  KC_NO,             KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO,
        KC_NO, KC_NO, KC_NO, KC_NO,  KC_NO,  KC_NO,             KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO,
        KC_NO, KC_NO, KC_NO, KC_NO,  KC_NO,  KC_NO,             KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO),
  [5] = LAYOUT(
        KC_NO, KC_NO, KC_NO, KC_NO,  KC_NO,  KC_NO,             KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO,
        KC_NO, KC_NO, KC_NO, KC_NO,  KC_NO,  KC_NO,             KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO,
        KC_NO, KC_NO, KC_NO, KC_NO,  KC_NO,  KC_NO,             KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO,
        KC_NO, KC_NO, KC_NO, KC_NO,  KC_NO,  KC_NO,             KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO,
        KC_NO, KC_NO, KC_NO, KC_NO,  KC_NO,  KC_NO,             KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO),
  [6] = LAYOUT(
        KC_NO, KC_NO, KC_NO, KC_NO,  KC_NO,  KC_NO,             KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO,
        KC_NO, KC_NO, KC_NO, KC_NO,  KC_NO,  KC_NO,             KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO,
        KC_NO, KC_NO, KC_NO, KC_NO,  KC_NO,  KC_NO,             KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO,
        KC_NO, KC_NO, KC_NO, KC_NO,  KC_NO,  KC_NO,             KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO,
        KC_NO, KC_NO, KC_NO, KC_NO,  KC_NO,  KC_NO,             KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO),
  [7] = LAYOUT(
        KC_NO, KC_NO, KC_NO, KC_NO,  KC_NO,  KC_NO,             KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO,
        KC_NO, KC_NO, KC_NO, KC_NO,  KC_NO,  KC_NO,             KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO,
        KC_NO, KC_NO, KC_NO, KC_NO,  KC_NO,  KC_NO,             KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO,
        KC_NO, KC_NO, KC_NO, KC_NO,  KC_NO,  KC_NO,             KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO,
        KC_NO, KC_NO, KC_NO, KC_NO,  KC_NO,  KC_NO,             KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO),
  [8] = LAYOUT(
        KC_NO, KC_NO, KC_NO, KC_NO,  KC_NO,  KC_NO,             KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO,
        KC_NO, KC_NO, KC_NO, KC_NO,  KC_NO,  KC_NO,             KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO,
        KC_NO, KC_NO, KC_NO, KC_NO,  KC_NO,  KC_NO,             KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO,
        KC_NO, KC_NO, KC_NO, KC_NO,  KC_NO,  KC_NO,             KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO,
        KC_NO, KC_NO, KC_NO, KC_NO,  KC_NO,  KC_NO,             KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO),
  [9] = LAYOUT(
        KC_NO, KC_NO, KC_NO, KC_NO,  KC_NO,  KC_NO,             KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO,
        KC_NO, KC_NO, KC_NO, KC_NO,  KC_NO,  KC_NO,             KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO,
        KC_NO, KC_NO, KC_NO, KC_NO,  KC_NO,  KC_NO,             KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO,
        KC_NO, KC_NO, KC_NO, KC_NO,  KC_NO,  KC_NO,             KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO,
        KC_NO, KC_NO, KC_NO, KC_NO,  KC_NO,  KC_NO,             KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO),
  [10] = LAYOUT(
        KC_NO, KC_NO, KC_NO, KC_NO,  KC_NO,  KC_NO,             KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO,
        KC_NO, KC_NO, KC_NO, KC_NO,  KC_NO,  KC_NO,             KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO,
        KC_NO, KC_NO, KC_NO, KC_NO,  KC_NO,  KC_NO,             KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO,
        KC_NO, KC_NO, KC_NO, KC_NO,  KC_NO,  KC_NO,             KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO,
        KC_NO, KC_NO, KC_NO, KC_NO,  KC_NO,  KC_NO,             KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO)
};
