/*
 * Rewrite of AutoREALM from Delphi/Object Pascal to wxWidgets/C++
 * Used in rpgs and hobbyist GIS applications for mapmaking
 * Copyright 2004-2006 The AutoRealm Team (http://www.autorealm.org/)
 * 
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the Lesser GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 * 
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 */
/**
 * @file
 */


#ifndef GRID_OBJECT_MODEL_H
#define GRID_OBJECT_MODEL_H


#include "ObjectInterface.h"


/** 
 * @brief GridObjectModel is used to store information about a grid that will be drawn on the screen.
 */
class GridObjectModel : public ObjectInterface
{
	public:
   		/**
		 * @brief The type of the grid used by this GridObjectModel.
		 */
		enum GridType
        { 
            gtNone = 1,     ///< No Grid.
            gtSquare,       ///< Grid with square shapes.
            gtHex,          ///< Grid with hexagonal shapes.
            gtTriangle,     ///< Grid with triangle shapes.
			gtRotatedHex,   ///< Grid with rotated hexagonal shapes.
            gtDiamond,      ///< Grid with diamond shapes.
            gtHalfDiamond,  ///< Grid with half diamond shapes.
            gtPolar         ///< Grid with polar shapes.
        };
        
		/**
		 * @brief The type of the pen that should be used to draw this
		 * GridObjectModel.
		 */
		enum GridPenStyle
        { 
            gpsDefault = 1, ///< Default pen style.
            gpsSingle,      ///< Single line pen sytle.
            gpsDot,         ///< Dot pen style.
            gpsDash,        ///< Dash pen style.
            gpsDashDot,     ///< Dash and dot pen style.
            gpsDashDotDot,  ///< Dash, dot and dot pen style.
            gpsBold         ///< Bold line pen style.
        };

        ///////////////////////////////////////////////    
        // Constructor and Destructor
        ///////////////////////////////////////////////	
        /**
         * @brief Default constructor which initialze all members
         * to their default values.
         */
		GridObjectModel();

        /**
         * @brief The default destructor for a GridObjectModel.
         */
        virtual ~GridObjectModel();

        ///////////////////////////////////////////////
        // Inherit virtual methods
        ///////////////////////////////////////////////
        /**
         * @brief Simple comparison to determine if two GridObjectModels
         * are equivalent.
         *
         * @param p_other A pointer to second GridObjectModel to compare to.
         * @return A flag whether the two objects are equivalent. 
         * @retval true  Yes the two objects are equivalent.
         * @retval false No the two objects are not equivalent.
         */
        virtual bool compare(const ObjectInterface* p_other) const;
    
        /**
         * @brief A copy method, useful for copying one GridObjectModel into another.
         *
         * @param p_other A pointer to second GridObjectModel to copy.
         * @return A flag whether the copy operation was successful. 
         * @retval true  The copy was successful.
         * @retval false The copy failed.
         */
        virtual bool copy(const ObjectInterface* p_other);
                
        /**
         * @brief Have all of the initialization steps been performed?
         *
         * @return A flag whether the two objects are equivalent. 
         * @retval true  Yes the object is valid.
         * @retval false No the object is not valid.
         */
        virtual bool isValid(void) const;

            
        ///////////////////////////////////////////////
        // Getter and Setter Methods
        ///////////////////////////////////////////////
        /**
         * @brief Get the bold units for this grid.
         * 
         * @return How many normal cells between bold cells.
         */
        int getBoldUnits() const;

        /**
         * @brief Get the current graph units for this grid.
         * 
         * @return The current graph units for this grid.
         */
        int getCurrentGraphUnits() const;

        /**
         * @brief Get the current grid size.
         * 
         * @return The current grid size.
         */
        double getCurrentGridSize() const;

        /**
         * @brief Get the flags of this grid.
         * 
         * @return The current flags of the grid.
         * @todo List all flag values here.
         */
        unsigned int getFlags() const;

        /**
         * @brief Get the scale factor for this grid.
         * 
         * @return The current scaling factor for this grid.
         */
        double getGraphScale() const;

        /**
         * @brief Get the graph units conversion factor for this grid.
         * 
         * @return The current graph unit conversion factor.
         */
        double getGraphUnitConvert() const;

        /**
         * @brief Get the current unit of measurement for this grid.
         * 
         * @return The current unit of measurement for this grid.
         */
        wxString getGraphUnits() const;

        /**
         * @brief Get the position of the grid.
         * 
         * @return The current position of the grid.
         */
        unsigned int getPosition() const;

        /**
         * @brief Get the pen style of the primary grid.
         * 
         * @return The current pen style for the primary grid.
         */
        GridObjectModel::GridPenStyle getPrimaryStyle() const;

        /**
         * @brief Get the pen style of the secondary grid.
         * 
         * @return The current pen style for the secondary grid.
         */
        GridObjectModel::GridPenStyle getSecondaryStyle() const;
        
        /**
         * @brief Get the current type of the grid.
         * 
         * @return The current grid type.
         */
        GridObjectModel::GridType getType() const;

        /**
         * @brief Set the bold units for this grid.
         * 
         * Each grid has a number of cells which are displayed in
         * bold. For square grids, it is common to put every fifth
         * cell in bold. That is what is meant by "bold units".
         * 
         * @param p_units How many normal cells between bold cells.
         */
        void setBoldUnits(unsigned int p_units);

        /**
         * @brief Set the current graph units for this grid.
         * 
         * @param p_units The new graph units for this grid.
         */
        void setCurrentGraphUnits(unsigned int p_units);

        /**
         * @brief Set the current grid size.
         * 
         * @param p_size The new grid size to use.
         */
        void setCurrentGridSize(double p_size);

        /**
         * @brief Set the flags of this grid.
         * 
         * @param p_flags The new flags for the grid.
         */
        void setFlags(unsigned int p_flags);

		/**
		 * @brief Set the scale of the grid.
		 * 
		 * @param p_scale The new scale for the grid.
		 */
		void setGraphScale(double p_scale);

		/**
		 * @brief Set the graph units conversion factor for this grid.
		 * 
		 * @param p_convert The new conversion factor.
		 */
		void setGraphUnitConvert(double p_convert);

		/**
		 * @brief Set the unit of measurement for this grid, in words.
		 * 
		 * @param p_units The new unit of measurement for this graph.
		 */
		void setGraphUnits(const wxString& p_units);

        /**
         * @brief Set the position of the grid.
         * 
         * @param p_position The new position of the grid.
         */
        void setPosition(unsigned int p_position);

        /**
         * @brief Set the pen style of the primary grid.
         * 
         * @param p_style The new pen style for the primary grid.
         */
        void setPrimaryStyle(GridObjectModel::GridPenStyle p_style);

        /**
         * @brief Set the pen style of the secondary grid.
         * 
         * @param p_style The new pen style for the secondary grid.
         */
        void setSecondaryStyle(GridObjectModel::GridPenStyle p_style);

		/**
		 * @brief Set the type of grid to use.
		 * 
		 * @param p_type The new type of grid.
		 */
		void setType(GridObjectModel::GridType p_type);

    private:
        /**
         * How many cells between cells to draw in bold.
         */
        unsigned int m_boldUnits;
        /**
         * The current number of pixels for each cell of the graph.
         */
        unsigned int m_currentGraphUnits;
        /**
         * The size of the grid.
         */
        double m_currentGridSize;
        /**
         * The flags to associate with this grid.
         */
        unsigned int m_flags;
    	/**
		 * The scale of the graph.
		 */
		double m_graphScale;
		/**
		 * The conversion factor for that scale.
		 */
		double m_graphUnitConvert;
		/**
		 * How many units are represented by each cell of the graph.
		 */
		wxString m_graphUnits;
		/**
		 * The position of the grid.
		 */
		unsigned int m_position;
		/**
		 * The pen style for the primary grid.
		 */
		GridObjectModel::GridPenStyle m_primaryStyle;
		/**
		 * The pen style for the secondary grid.
		 */
		GridObjectModel::GridPenStyle m_secondaryStyle;
        /**
         * The type of the grid.
         */
        GridObjectModel::GridType m_type;
};


#endif  // GRID_OBJECT_MODEL_H
