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


#ifndef VIEW_POINT_MODEL_H
#define VIEW_POINT_MODEL_H


#include "ObjectInterface.h"


/**
 * @brief This object represents a viewpoint. As it can be manipulated
 * like any other map object, it is descended from ObjectInterface.
 *
 * This class encapsulates all of the <em>data</em> regarding a specific
 * ViewPoint in a map. It does not attempt to discuss how to draw it,
 * leaving that to a ViewPointView class, or ViewPointObserver class.
 * 
 * How to use a ViewPointModel object:
 * @code
 * ObjectInterface* top = new ObjectInterface;
 * 
 * ViewPointModel* vp = new ViewPointModel;
 * vp->setName(wxT("actual view point"));
 * ... do something more with vp ...
 * top->addChild(vp);
 * 
 * delete top; // delete also the child vp!
 * @endcode
 */
class ViewPointModel : public ObjectInterface
{
	public:
        ///////////////////////////////////////////////    
        // Constructor and Destructor
        ///////////////////////////////////////////////    
		/**
		 * @brief Default constructor. If you want to set the parent object
         * use the addChild method from the upper class ObjectInterface.
		 */
		ViewPointModel();

        /**
         * @brief The default destructor for an ObjectInterface.
         */
        virtual ~ViewPointModel();

        ///////////////////////////////////////////////
        // Inherit virtual methods
        ///////////////////////////////////////////////
        /**
         * @brief Simple comparison to determine if two ViewPointModel
         * objects are equivalent.
         *
         * @param p_other A pointer to second ViewPointModel to compare to.
         * @return A flag whether the two object are equivalent. 
         * @retval true  Yes the two objects are equivalent.
         * @retval false No the two objects are not equivalent.
         */
        virtual bool compare(const ObjectInterface* p_other) const;
    
        /**
         * @brief A copy method, useful for copying one ViewPointModel into another.
         *
         * @param p_other A pointer to second LineObjectModel to copy.
         * @return A flag whether the copy operation was successful. 
         * @retval true  The copy was successful.
         * @retval false The copy failed.
         * @warning The children will not be copy!
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
		 * @brief Get the area covered by this ViewPointModel.
		 *
		 * @return The area covered by this ViewPointModel.
		 */
		arRealRect getArea() const;

        /**
         * @brief Get the height of the ViewPointModel.
         * 
         * @return The current height as a double.
         */
        double getHeight() const
        {
            return m_height;
        };

        /** 
         * @brief Get the name of this ViewPointModel.
         * 
         * @return A string representing the name of this ViewPointModel.
         */
        wxString getName() const;

        /**
         * @brief Get the width of the ViewPointModel.
         * 
         * @return The current width as a double.
         */
        double getWidth() const
        {
            return m_width;
        };

        /** 
         * @brief Get the current zoom level.
         * 
         * @return The current zoom level, expressed as a double.
         * @retval 100 Is 100% Zoom.
         */
        double getZoom() const;

		/** 
		 * @brief Set the area covered by this ViewPointModel to a new arRealRect.
		 * 
		 * @param p_area The arRealRect representing the new area covered by this
		 * ViewPointModel.
		 */
		void setArea(const arRealRect& p_area);

        /**
         * @brief Set the height of the ViewPointModel.
         * 
         * @param p_height The new height as a double.
         */
        void setHeight(double p_height)
        {
            m_height = p_height;
        };
        
		/** 
		 * @brief Set the name of this ViewPointModel.
		 * 
		 * @param p_name A string containing the name of this ViewPointModel.
		 */
		void setName(const wxString& p_name);

        /**
         * @brief Set the width of the ViewPointModel.
         * 
         * @param p_width The new width.
         */
        void setWidth(double p_width)
        {
            m_width = p_width;
        };

		/** 
		 * @brief Set the current zoom level
		 * 
		 * @param p_zoom The new zoom level to use, expressed as a
		 * double. 100=100% Zoom
		 */
		void setZoom(double p_zoom);

        ///////////////////////////////////////////////
        // Getter and Setter Methods of Overlays
        ///////////////////////////////////////////////
        /**
         * @brief Get the status of all overlays for this object.
         * 
         * @return The entire OverlayVector for the active overlays
         * for this object.
         */
        OverlayVector getActiveOverlays() const
        { 
            return m_activeOverlays;
        };

        /**
         * @brief Get the status of a single overlay.
         * 
         * @param p_overlay The index of the overlay to get the status.
         * @return The status of the single overlay. 
         * @retval true  The overlay is active.
         * @retval false The overlay is inactive or the index is out of bonds.
         */
        bool getOverlayActive(unsigned int p_overlay) const
        {
            bool retval = false;
            if (p_overlay < m_activeOverlays.size())
            {
                retval = m_activeOverlays.at(p_overlay);
            }
            return retval;
        };

		/**
		 * @brief Get the status of all overlays for this object.
		 * 
		 * @return The entire OverlayVector for the visible overlays
		 * for this object.
		 */
		OverlayVector getVisibleOverlays() const
        { 
            return m_visibleOverlays;
        };

		/**
		 * @brief Get the status of a single overlay.
		 * 
         * @param p_overlay The index of the overlay to get the status.
		 * @return The status of the single overlay.
         * @retval true  The overlay is visible.
         * @retval false The overlay is invisible or the index is out of bonds.
		 */
		bool getOverlayVisible(unsigned int p_overlay) const
        {
            bool retval = false;
		    if (p_overlay < m_visibleOverlays.size())
            {
                retval = m_visibleOverlays.at(p_overlay);
		    }
		    return retval;
        };
            
        /**
         * @brief Reset the status of all overlays for this object.
         * 
         * @param p_active The new overlay vector to use.
         */
        void setActiveOverlays(const OverlayVector& p_active)
        {
            m_activeOverlays = p_active;
        };

        /**
         * @brief Set a single overlay as active.
         * 
         * @param p_overlay The index of the overlay to set as active.
         */
        void setOverlayActive(unsigned int p_overlay)
        {
            if (p_overlay < m_activeOverlays.size())
            {
                m_activeOverlays.at(p_overlay) = true;
            }
        };
        
        /**
         * @brief Set a single overlay as inactive.
         * 
         * @param p_overlay The index of the overlay to mark as inactive.
         */
        void setOverlayInactive(unsigned int p_overlay)
        {
            if (p_overlay < m_activeOverlays.size())
            {
                m_activeOverlays.at(p_overlay) = false;
            }
        };

        /**
         * @brief Reset the status of all overlays for this object.
         * 
         * @param p_visible The new overlay vector to use.
         */
        void setVisibleOverlays(const OverlayVector& p_visible)
        {
            m_visibleOverlays = p_visible;
        };

        /**
         * @brief Set a single overlay as visible.
         * 
         * @param p_overlay The index of the overlay to set as visible.
         */
        void setOverlayVisible(unsigned int p_overlay)
        {
            if (p_overlay < m_activeOverlays.size())
            {
                m_visibleOverlays.at(p_overlay) = true;
            }
        };
        
        /**
         * @brief Set a single overlay as invisible.
         * 
         * @param p_overlay The index of the overlay to mark as invisible.
         */
        void setOverlayInvisible(unsigned int p_overlay)
        {
            if (p_overlay < m_activeOverlays.size())
            {
                m_visibleOverlays.at(p_overlay) = false;
            }
        };
        
    private:
		/** 
		 * @brief The area which is visible in this ViewPointModel.
		 */
		arRealRect m_area;

		/** 
		 * @brief The name of this ViewPointModel.
		 */
		wxString m_name;

		/** 
		 * @brief The zoom factor to use for this ViewPointModel.
		 */
		double m_zoom;

        /**
         * @brief The height of this ViewPointModel.
         */
        double m_height;
        
		/**
		 * @brief The width of this ViewPointModel.
		 */
		double m_width;

        /**
         * @brief The vector of active overlays for this view.
         */
        OverlayVector m_activeOverlays;

		/**
		 * @brief The vector of visible overlays for this view.
		 */
		OverlayVector m_visibleOverlays;
};


#endif  // VIEW_POINT_MODEL_H
