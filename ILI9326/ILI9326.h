/*************************************************************************************************
 * This file is part of ILI9326
 *
 * Copyright (C) 2011, 2012 - Nenad Radulovic
 *
 * ILI9326 is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * ILI9326 is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with ILI9326; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin St, Fifth Floor,
 * Boston, MA  02110-1301  USA
 *
 * web site:    http://blueskynet.dyndns-server.com
 * e-mail  :    blueskyniss@gmail.com
 *************************************************************************************************/


/*********************************************************************************************//**
 * @file
 *
 * @author  	nesa
 *
 * @brief       Interfejs ILI9326 drajvera.
 *
 * ------------------------------------------------------------------------------------------------
 *
 * @addtogroup  ILI9326_intf
 *
 ****************************************************************************************//** @{ */


#ifndef ILI9326_H_
#define ILI9326_H_


/*************************************************************************************************
 * INCLUDE FILES
 *************************************************************************************************/

/*-----------------------------------------------------------------------------------------------*
 * Module dependencies
 *-----------------------------------------------------------------------------------------------*/

#include "ILI9326_lld.h"
#include "font.h"


/*-----------------------------------------------------------------------------------------------*
 * Module configuration and adapter
 *-----------------------------------------------------------------------------------------------*/


/*-----------------------------------------------------------------------------------------------*
 * EXTERNS
 *-----------------------------------------------------------------------------------*//** @cond */

#ifdef ILI9326_H_VAR
# define ILI9326_H_EXT
#else
# define ILI9326_H_EXT extern
#endif


/** @endcond*//***********************************************************************************
 * DEFINES
 *************************************************************************************************/

/*-------------------------------------------------------------------------------------------*//**
 * @name        Predefinisane boje
 * @{ *//*---------------------------------------------------------------------------------------*/

#define BLACK           RGBCONV(0U  , 0U  , 0U  )
#define BRIGHTBLUE      RGBCONV(0U  , 0U  , 255U)
#define BRIGHTGREEN     RGBCONV(0U  , 255U, 0U  )
#define BRIGHTCYAN      RGBCONV(0U  , 255U, 255U)
#define BRIGHTRED       RGBCONV(255U, 0U  , 0U  )
#define BRIGHTMAGENTA   RGBCONV(255U, 0U  , 255U)
#define BRIGHTYELLOW    RGBCONV(255U, 255U, 0U  )
#define BLUE            RGBCONV(0U  , 0U  , 128U)
#define GREEN           RGBCONV(0U  , 128U, 0U  )
#define CYAN            RGBCONV(0U  , 128U, 128U)
#define RED             RGBCONV(128U, 0U  , 0U  )
#define MAGENTA         RGBCONV(128U, 0U  , 128U)
#define YELLOW          RGBCONV(255U, 255U, 128U)
#define BROWN           RGBCONV(255U, 128U, 0U  )
#define LIGHTGRAY       RGBCONV(128U, 128U, 128U)
#define DARKGRAY        RGBCONV(64U , 64U , 64U )
#define LIGHTBLUE       RGBCONV(128U, 128U, 255U)
#define LIGHTGREEN      RGBCONV(128U, 255U, 128U)
#define LIGHTCYAN       RGBCONV(128U, 255U, 255U)
#define LIGHTRED        RGBCONV(255U, 128U, 128U)
#define LIGHTMAGENTA    RGBCONV(255U, 128U, 255U)
#define WHITE           RGBCONV(255U, 255U, 255U)

/** @} *//*--------------------------------------------------------------------------------------*/


/*************************************************************************************************
 * MACRO's
 *************************************************************************************************/

#define RGBCONV(red, green,blue )                                                 \
    ((((red) >> 3) << 11) | (((green) >> 2) << 5) | ((blue) >> 3))


/*-----------------------------------------------------------------------------------------------*
 * C++ zastita - pocetak
 *-----------------------------------------------------------------------------------------------*/
#ifdef __cplusplus
extern "C"
{
#endif


/*************************************************************************************************
 * DATA TYPES
 *************************************************************************************************/


/*************************************************************************************************
 * GLOBAL VARIABLES
 *************************************************************************************************/


/*************************************************************************************************
 * FUNCTION PROTOTYPES
 *************************************************************************************************/

/*-----------------------------------------------------------------------------------------------*/
/**
 * @brief       Crta sprekidanu liniju na displeju
 *
 * @param       x1                      x koordinata pocetka
 * @param       y1                      y koordinata pocetka
 * @param       x2                      x koordinata kraja
 * @param       y2                      y koordinata kraja
 * @param       color                   boja linije
 */
/*-----------------------------------------------------------------------------------------------*/
void drawCutLine(
    uint16_t x1,
    uint16_t y1,
    uint16_t x2,
    uint16_t y2,
    uint16_t color);

/*-----------------------------------------------------------------------------------------------*/
/**
 * @brief       Crta liniju na displeju
 *
 * @param       x1                      x koordinata pocetka
 * @param       y1                      y koordinata pocetka
 * @param       x2                      x koordinata kraja
 * @param       y2                      y koordinata kraja
 * @param       color                   boja linije
 */
/*-----------------------------------------------------------------------------------------------*/
void drawLine(
    uint16_t x1,
    uint16_t y1,
    uint16_t x2,
    uint16_t y2,
    uint16_t color);

/*-----------------------------------------------------------------------------------------------*/
/**
 * @brief       Stampa tekst na displeju
 *
 * @param       x                       x koordinata teksta,
 * @param       y                       y koordinata teksta,
 * @param       pText                   pokazivac na tekst,
 * @param       font                    pokazivac na font,
 * @param       height                  debljina (visina) fonta,
 * @param       color                   boja teksta.
 */
/*-----------------------------------------------------------------------------------------------*/
void drawText(
    uint16_t x,
    uint16_t y,
    const char *pText,
    const int8_t (*font)[5],
    uint8_t height,
    uint16_t color);

/*-----------------------------------------------------------------------------------------------*/
/**
 * @brief       Crta pravugaonik ispunjen bojom @c color.
 *
 * @param       x1                      x koordinata prve tacke,
 * @param       y1                      y koordinata prve tacke,
 * @param       x2                      x koordinata zadnje tacke,
 * @param       y2                      y koordinata zadnje tacke,
 * @param       color                   boja ispune.
 * @note        Moraju biti zadovoljeni sledeci uslovi:
 *              - x1 < x2
 *              - y1 < y2
 *              U suprotnom, ponasanje funkcije je nedefinisano.
 */
/*-----------------------------------------------------------------------------------------------*/
void drawFilledRectangle(
    uint16_t x1,
    uint16_t y1,
    uint16_t x2,
    uint16_t y2,
    uint16_t color);

/*-----------------------------------------------------------------------------------------------*/
/**
 * @brief       Crta pravugaonik boje @c color.
 *
 * @param       x1                      x koordinata prve tacke,
 * @param       y1                      y koordinata prve tacke,
 * @param       x2                      x koordinata zadnje tacke,
 * @param       y2                      y koordinata zadnje tacke,
 * @param       color                   boja ispune.
 * @note        Moraju biti zadovoljeni sledeci uslovi:
 *              - x1 < x2
 *              - y1 < y2
 *              U suprotnom, ponasanje funkcije je nedefinisano.
 */
/*-----------------------------------------------------------------------------------------------*/
void drawRectangle(
    uint16_t x1,
    uint16_t y1,
    uint16_t x2,
    uint16_t y2,
    uint16_t color);

/*-----------------------------------------------------------------------------------------------*/
/**
 * @brief       Postavlja sliku iz ROM/FLASH memorije na LCD.
 *
 * @param       image                   Pokazivac na podatke slike,
 * @param       x                       x koordinata pocetka slike na LCD-u,
 * @param       y                       y koordinata pocetka slike na LCD-u.
 * @note        Slika je u 16-bitnom formatu.
 *
 *              Generator slike i opis formata zapisa slike se moze naci u
 *              Microchipovoj biblioteci za graficke aplikacije.
 */
/*-----------------------------------------------------------------------------------------------*/
void drawFlashImage(
    const uint8_t * image,
    uint16_t x,
    uint16_t y);


/*-----------------------------------------------------------------------------------------------*
 * C++ zastita - kraj
 *-----------------------------------------------------------------------------------------------*/
#ifdef __cplusplus
}
#endif


/*************************************************************************************************
 * CONFIGURATION ERRORS
 *************************************************************************************//** @cond */


/** @endcond *//** @} *//*************************************************************************
 * END of ILI9326.h
 *************************************************************************************************/
#endif /* ILI9326_H_ */
