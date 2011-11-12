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


#ifndef AR_DOCUMENT_H
#define AR_DOCUMENT_H


#include "ObjectInterface.h"
#include "Pushpin.h"


/**
 * @brief This object represents an entire map in memory.
 */
class ARDocument : public ObjectInterface
{
	public:
        ///////////////////////////////////////////////    
        // Constructor and Destuctor
        ///////////////////////////////////////////////    
        /**
         * @brief Default constructor which initialze all members
         * to their default values.
         */
		ARDocument();
		
        /**
         * @brief Destructor. Cleans up all owned memory.
         */
		virtual ~ARDocument();

        ///////////////////////////////////////////////
        // Inherit virtual methods
        ///////////////////////////////////////////////
        /**
         * @brief Simple comparison to determine if two ARDocuments
         * are equivalent.
         *
         * Note that this method really does compare two documents,
         * entirely. It compares all attributes of the ARDocument, then
         * compares each and every child. Note that all children must
         * appear in the same order, and be identical, for the ARDocument
         * to be considered identical.

         * @param p_other A pointer to second ARDocument to compare to.
         * @return A flag whether the two objects are equivalent. 
         * @retval true  Yes the two objects are equivalent.
         * @retval false No the two objects are not equivalent.
         */
        virtual bool compare(const ObjectInterface* p_other) const;
        
        /**
         * @brief A copy method, useful for copying one ARDocument into another.
         *
         * @param p_other A pointer to second ARDocument to copy.
         * @return A flag whether the copy operation was successful. 
         * @retval true  The copy was successful.
         * @retval false The copy failed.
         */
        virtual bool copy(const ObjectInterface* p_other);

        /**
         * Have all of the initialization steps been performed?
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
         * @brief Get the current background color.
         * 
         * @return The current background color.
         */
        wxColor getBgColor(void) const;

        /** 
         * @brief Get the user generated comments for this document.
         * 
         * @return The user generated comments for this document.
         */
        wxString getComments(void) const;

        /** 
         * @brief Get the design grid units member.
         * 
         * @return The design grid unit value.
         */
        unsigned int getDesignGridUnits(void) const
        {
            return m_designGridUnits;
        };
        
        /**
         * @brief Get the display grid member.
         * 
         * @return The value of the member.
         * @retval true  The grid is showed on the display.
         * @retval false The grid is not showed on the display.
         */
        bool getDisplayGrid(void) const
        {
            return m_displayGrid;
        };

        /** 
         * @brief Get the current color of the grid.
         * 
         * @return The current color of the grid.
         */
        wxColor getGridColor(void) const;

        /** 
         * @brief Get the current landscape orientation.
         * 
         * @return The current landscape orientation.
         * @retval true  The map has a landscape orientation.
         * @retval false The map has not a landscape orientation.
         */
        bool getLandscape(void) const;

        /** 
         * @brief Get the count of overlays attached to this document.
         * 
         * @return The count of overlays attached to this document.
         */
        unsigned int getOverlayCount(void) const;

        /** 
         * @brief Get the name of a specified overlay.
         * 
         * @param p_index The 0 based index of the overlay to retrieve.
         * @return The name of the overlay.
         */
        wxString getOverlayName(unsigned int p_index) const throw (ARMissingOverlayException);

        /**
         * @brief Get information on a specific pushpin.
         *
         * @param p_index The number of the pushpin to get.
         * @return The pushpin indicated by the index.
         */
        Pushpin getPushpin(unsigned int p_index) const throw (ARInvalidPushpin);

        /**
         * @brief Get the information on all pushpins, the entire collection.
         *
         * @return The pushpin collection for this document.
         */
        PushpinCollection getPushpins(void) const;

        /** 
         * @brief Get the rotate snap member.
         * 
         * @return The value of the member.
         * @retval true  The snap is rotated.
         * @retval false The snap is not rotated.
         */
        bool getRotateSnap(void) const
        {
            return m_rotateSnap;
        };

        /** 
         * @brief Get the snap to grid member.
         * 
         * @return The value of the member.
         * @retval true  The snap to grid.
         * @retval false There is no snap to grid.
         */
        bool getSnapToGrid(void) const
        {
            return m_snapToGrid;
        };

        /** 
         * @brief Get the snap along member.
         * 
         * @return The value of the member.
         * @retval true  The snap along an object.
         * @retval false There is no snap to an object.
         */
        bool getSnapAlong(void) const
        {
            return m_snapAlong;
        };

        /** 
         * @brief Get the snap to point member.
         * 
         * @return The value of the member.
         * @retval true  The snap to a point.
         * @retval false There is no snap to a point.
         */
        bool getSnapToPoint(void) const
        {
            return(m_snapToPoint);
        };

		/** 
		 * @brief Get the version number of the document.
		 * 
		 * @return The version number of the document.
		 */
		unsigned int getVersion(void) const;

        /** 
         * @brief Set the background color to a new color.
         *
         * Note that p_bgColor.Ok() must be true otherwise
         * it will be throw an ARBadColorException.
         * 
         * @param p_bgColor The new color to use.
         */
        void setBgColor(const wxColor& p_bgColor) throw(ARBadColorException);

        /** 
         * @brief Set the user generated comments for this document.
         * 
         * @param p_comments The new comments to use for this document.
         */
        void setComments(const wxString& p_comments);

        /** 
         * @brief Set the design grid units member.
         * 
         * @param p_units What to set it to.
         */
        void setDesignGridUnits(unsigned int p_units)
        {
            m_designGridUnits = p_units;
        };

        /** 
         * @brief Set the display grid member.
         * 
         * @param p_snap What to set it to.
         */
        void setDisplayGrid(bool p_snap)
        {
            m_displayGrid = p_snap;
        };

		/** 
		 * @brief Set the grid color to a new color.
		 * 
		 * Note that p_gridColor.Ok() must be true otherwise
         * it will throw an ARBadColorException.
		 *
		 * @param p_gridColor The new color to use.
		 */
		void setGridColor(const wxColor& p_gridColor) throw(ARBadColorException);

        /** 
         * @brief Change the landscape orientation.
         * 
         * @param p_landscape True to set the landscape orientation.
         */
        void setLandscape(bool p_landscape);

		/** 
		 * @brief Set the 0 based overlay name to a new value.
		 * 
		 * @param p_index The index of the overlay to set.
		 * @param p_overlay The new overlay name.
		 */
		void setOverlayName(unsigned int p_index, const wxString& p_overlay) throw (ARMissingOverlayException);

        /**
         * @brief Set a specific pushpin.
         *
         * @param p_index The number of the pushpin to set.
         * @param p_pin The new pushpin information to use.
         */
        void setPushpin(unsigned int p_index, const Pushpin& p_pin) throw (ARInvalidPushpin);

        /**
         * @brief Set the information on all pushpins, the entire collection.
         *
         * @param p_pins The new collection of Pushpins to use for this document.
         */
        void setPushpins(const PushpinCollection& p_pins);
        
        /** 
         * @brief Set the rotate snap member.
         * 
         * @param p_snap True if the snap is rotated. 
         */
        void setRotateSnap(bool p_snap)
        {
            m_rotateSnap = p_snap;
        };

        /** 
         * @brief Set the snap along member.
         * 
         * @param p_snap True if the snap along an object is active. 
         */
        void setSnapAlong(bool p_snap)
        {
            m_snapAlong = p_snap;
        };

		/** 
		 * @brief Set the snap to grid member.
		 * 
		 * @param p_snap True if the snap to grid is active. 
		 */
		void setSnapToGrid(bool p_snap)
        {
            m_snapToGrid = p_snap;
        };

		/** 
		 * @brief Set the snap to point member.
		 * 
         * @param p_snap True if the snap to point is active. 
		 */
		void setSnapToPoint(bool p_snap)
        {
            m_snapToPoint = p_snap;
        };

        /** 
         * @brief Set the version number of the document. Current, XML file
         * format is version 6.
         * 
         * @param p_version The version number of the document.
         */
        void setVersion(unsigned int p_version);

        ///////////////////////////////////////////////
        // Other Methods
        ///////////////////////////////////////////////
        /** 
         * @brief Add an overlay name to this document.
         * 
         * @param p_overlay The name of the overlay to add.
         * @return The 0 based index for this overlay.
         */
        unsigned int addOverlayName(const wxString& p_overlay);

    private:
        /** 
         * @brief The current background color.
         */
        wxColor m_bgColor;

        /**
         * @brief The user set comments for this map.
         */
        wxString m_comments;

        /** 
         * @brief The size of the design grid units.
         */
        unsigned int m_designGridUnits;

        /** 
         * @brief Indicate whether to show the grid or not for this document.
         */
        bool m_displayGrid;

  		/** 
 		 * @brief The current grid color.
 		 */
 		wxColor m_gridColor;
 
        /** 
         * @brief Whether or not this document is oriented in landscape fashion.
         */
        bool m_landscape;

		/**
		 * @brief The list of overlay names for this map.
		 */
		std::vector<wxString> m_overlays;

        /**
         * @brief The pushpin collection for this map.
         */
        PushpinCollection m_pins;

        /** 
         * @brief Indicate whether to rotate the snap.
         */
        bool m_rotateSnap;
        
        /** 
         * @brief Indicate whether to snap along lines for this document.
         */
        bool m_snapAlong;

        /** 
         * @brief Indicate whether to snap to the grid for this document.
         */
        bool m_snapToGrid;

		/** 
		 * @brief Indicate whether to snap to points for this document.
		 */
		bool m_snapToPoint;

        /** 
         * @brief The version of the document.
         */
        unsigned int m_version;

};


#endif  // AR_DOCUMENT_H
