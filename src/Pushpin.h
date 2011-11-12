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

#ifndef PUSHPIN_H
/**
 * Used to prevent multiple includes of this file
 */
#define PUSHPIN_H 1
#include <wx/wx.h>
#include <vector>

#include <arRealTypes.h>

/**
 * The maximum number of pushpins. The number is arbitrarily chosen for
 * now. And should be trivially changed.
 */
const unsigned int MAX_PUSHPINS=15;

/**
 * The locations that a given pushpin has had over time. Locations include
 * notes, which can be used to indicate why something changed, or dates
 * they changed, etc.
 *
 * They are stored in memory with newest changes first, oldest last. This
 * is also how they should be stored on disk.
 *
 * Note that, due to the size of this class, all members are public.
 * There's little justification for making them private.
 */
class PushpinHistory {
	public:
		/**
		 * The point the pushpin occupied
		 */
		arRealPoint m_point;
		/**
		 * The note associated with this location.
		 */
		wxString m_note;

		/**
		 * Default constructor
		 */
		PushpinHistory(arRealPoint p_pt=arRealPoint(0.0, 0.0), wxString p_nt=wxT(""));

		/**
		 * Comparison (equality) operator
		 *
		 * Two history entries are equal iff the note and the point are
		 * equal
		 */
		bool operator==(const PushpinHistory& p_other) const;
};

/**
 * Convenience definition for use with the PushpinHistory
 */
typedef std::vector<PushpinHistory> PinHistory;

/**
 * The actual class for a single instance of a pushpin.
 *
 * This holds information about whether or not the pushpin is checked
 * (visible on the map), placed (whether or not the pin has been placed
 * onto the map), the point (the location where the pin can be seen), name
 * (the name of the pin), and the historical locations of the pin.
 *
 * Due to the size of this class, little justification can be made for
 * having accessors. As such, all members are public.
 */
class Pushpin {
	public:
		/**
		 * Default constructor
		 */
		Pushpin();
		/**
		 * @brief get a history location for this pin
		 *
		 * @param p_index The index of the history entry
		 *
		 * @return The history entry
		 */
		PushpinHistory getHist(unsigned int p_index=0);
		/**
		 * @brief Append a history entry to the list
		 *
		 * @param p_ph The history entry to append
		 */
		void addHist(PushpinHistory p_ph);
		/**
		 * Comparison (equality) operator
		 *
		 * Two pushpins are equal iff m_checked, m_placed, m_point, m_name
		 * are equal, and both have the same history entries
		 */
		bool operator==(Pushpin& p_other) const;

		/**
		 * Is this pin checked to be visible on the map?
		 */
		bool m_checked;
		/**
		 * Has the pin been placed on the map
		 */
		bool m_placed;
		/**
		 * Where has the pin been placed?
		 */
		arRealPoint m_point;
		/**
		 * What is the name associated with this pin?
		 */
		wxString m_name;
		/**
		 * What are the historical locations of this pin?
		 */
		PinHistory m_history;
};

/**
 * The set of pushpins for a given document
 *
 * This is simply a way of grouping all information about the set of
 * pushpins for a given ARDocument, allowing easy storage and access
 *
 * Again, the size means that all members are public.
 */
class PushpinCollection {
	public:
		/**
		 * Default constructor
		 */
		PushpinCollection();
		/**
		 * Should waypoints on the pushpin histories be visible?
		 */
		bool m_waypointsVisible;
		/**
		 * Should the pushpin waypoint numbers be shown?
		 */
		bool m_showNumber;
		/**
		 * Should the notes at each waypoint be shown?
		 */
		bool m_showNote;
		/**
		 * The collection of pins managed by this class
		 */
		std::vector<Pushpin> m_pins;
		/**
		 * Comparison (equality) operator
		 *
		 * Two PushpinCollection's are equal iff m_waypointsVisible,
		 * m_showNumber, m_showNote, are equal, and all managed pins are
		 * equal.
		 */
		bool operator==(const PushpinCollection& p_other) const;
};
#endif //PUSHPIN_H
