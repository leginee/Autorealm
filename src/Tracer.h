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
 * @todo Modify all source files to use these TRACEFLAG/TRACER/TRACE macros appropriately
 */

#ifndef TRACER_H
#define TRACER_H

#include <vector>

#include <wx/wx.h>

/**
 * @brief:  class to assist in tracing construction/destruction
 */
class Tracer
{
	public:
		Tracer(const wxString& traceFlag, 	const wxString& message);
		
		~Tracer();
		
		void trace(const wxString& p_msg);

	protected:
		wxString		m_traceFlag;
		wxString		m_message;
};

typedef std::vector<wxString> tracesvector;

class TracerSingleton {
	public:
		static tracesvector* Get() {
			if (m_traces == NULL) {
				m_traces = new tracesvector;
			}
			return(m_traces);
		}
	private:
		static tracesvector* m_traces;
};
#ifdef __WXDEBUG__
/**
 * Use this to define the traceflag that needs to be turned on for events in
 * this file to be seen. Basically, this defines the flag for this file. In
 * addition, it registers the flag with the global trace flag registry, so that
 * all trace flags can be turned on easily.
 * 
 * @param a The name of the traceflag for this file
 */
#define TRACEFLAG(a) namespace {\
	const wxString className(a);\
	class TraceFlagRegister {\
		public:\
			TraceFlagRegister() {\
				tracesvector* v=TracerSingleton::Get();\
				v->insert(v->end(), ::className);\
			}\
	};\
	TraceFlagRegister tfr;\
}
/**
 * Place this at the beginning of a function or method to add a tracer.
 * Basically, this #define will put entry and exit statements at the entry
 * and exit points of a function/method.
 * 
 * This requires that TRACEFLAG be used first.
 * 
 * @param b The name of the method/function being traced
 */
#define TRACER(b) Tracer ___tracerObj(::className, b)
/**
 * Use this to issue an immediate trace statement.
 * 
 * This requires that TRACER be used first.
 * 
 * @param b The statement to be printed to the trace logs.
 */
#define TRACE(b, ...) {\
	wxString tmsg;\
	tmsg.Printf(b, ## __VA_ARGS__);\
	___tracerObj.trace(tmsg);\
}
#else
#define TRACEFLAG(a)
#define TRACER(b)
#define TRACE(b, ...)
#endif

#endif /*TRACER_H_*/
