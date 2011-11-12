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
 * 
 * First in this file, we have a list of the valid tags which appear in a
 * file. The indentation level indicates which tags are subtags. Note that
 * this was done mainly to facilitate the production of SubBuilder classes
 * below. It serves no functional purpose at this time, though it was put
 * into an array of wxString in the event that it might be useful.
 * 
 * Second comes a long set of utility methods for converting string data
 * into various in-memory data types. Some of them are probably unnecessary,
 * but having them does help maintain readability.
 * 
 * Next comes the most important part of this file: SubBuilder and
 * sub-classes thereof. The SubBuilder is the piece which is responsible
 * for actually constructing objects, and setting attributes. As a result,
 * the SubBuilder object for a given class needs detailed knowledge for the
 * object being built. The abstraction in place, though, allows the
 * ObjectBuilder to completely ignore the differences.
 * 
 * Now, how to add a new SubBuilder?
 * 
 * 1) Go to SubBuilderFactory::Get(), and add a line which returns a pointer
 *    to the new SubBuilder class.
 * 2) Create the new SubBuilder class, providing startObject() and
 *    endObject() methods. Use existing classes as templates for how to
 *    proceed.
 * 
 * As a final note, realize that a SubBuilder does *not* need to work on a
 * full object. For instance, this file provides OverlayBuilder, which works
 * on a sub-section of an ARDocument. By using the facilities provided, it
 * is able to act on the ARDocument safely.
 *
 */

#ifndef SUB_BUILDER_H
#define SUB_BUILDER_H


#include "ARDocument.h"
#include "DrawnObjectModel.h"
#include "GridObjectModel.h"
#include "base64.h"


namespace subbuilderComponents
{
    // Forward declarations
    class SubBuilder;
    class ARDocumentBuilder;
    class CurveModelBuilder;
    class GridObjectBuilder;
    class GroupModelBuilder;
    class LineModelBuilder;
    class OverlayBuilder;
    class PolyCurveModelBuilder;
    class PolyLineModelBuilder;
    class PushpinBuilder;
    class ViewPointBuilder;
    
    
    /**
     * @brief The entries for the BuilderStack.
     * 
     * Basically, each entry in the stack needs to know which SubBuilder to use,
     * which object it is attached to, and what tag it is working on.
     */
    struct BuilderStackEntry
    {
        public:
            /**
             * @brief The SubBuilder object which is used.
             */
            SubBuilder* m_bldr;
            /**
             * @brief The ObjectInterface object which is attached to.
             */
            ObjectInterface* m_obj;
            /**
             * @brief The tag object.
             */
            wxString m_tag;
    };
    
    /**
     * @brief The stack of tags, objects, and SubBuilders to work on them.
     */
    extern std::vector<BuilderStackEntry> bldrstack;

    /**
     * @brief The top level class for the SubBuilder hierarchy.
     * 
     * Provides implementations of setDoc, getDoc, and addAttribs. Makes known
     * the requirement to implement startObject and endObject in all SubBuilders.
     */
    class SubBuilder
    {
        public:
            /**
             * This is used to make gcc happy, by adding a virtual destructor.
             * While it doesn't need to do anything, this does remove one
             * warning from the list of warnings when the build is run in
             * DEBUG=1 mode.
             */
            virtual ~SubBuilder() {};
        
            /**
             * Get the document object used by the SubBuilder
             * 
             * @return ARDocument* for use by this SubBuilder
             */
            ARDocument* getDoc() {return(m_doc);};
            
            /**
             * Set the document object used by the SubBuilder
             * 
             * @param p_doc The ARDocument* used by this SubBuilder
             */
            void setDoc(ARDocument* p_doc) {m_doc=p_doc;};
            
            /**
             * The basic prototype for the startObject method. Must always
             * be overridden. Called at the beginning of a new tag.
             * 
             * @param p_tag The BuilderStackEntry to be used for this
             * invocation of startObject
             */
            virtual void startObject(BuilderStackEntry& p_tag) = 0;
                    
            /**
             * The basic prototype for the endObject method. Must always
             * be overridden. Called at the end of a tag.
             * 
             * @param p_tag The BuilderStackEntry to be used for this
             * invocation of startObject. This stack entry can be modified
             * by calling startObject!
             */
            virtual void endObject(const BuilderStackEntry& p_tag) = 0;
            
            /**
             * Used to add a set of attributes to an ObjectInterface*. The
             * ObjectInterface* is stored in the BuilderStackEntry
             * 
             * @param p_attribs The list of attributes to add to the object
             * @param p_tag The BuilderStackEntry for this object
             */
            void addAttribs(const ObjectAttributes p_attribs, BuilderStackEntry& p_tag);
            
        protected:
            /**
             * The document being built by this SubBuilder
             */
            ARDocument* m_doc;
    };


    /********************************************************************/
    /*                    Factory/Util Classes                          */
    /********************************************************************/

    /**
     * @brief The SubBuilderFactory, which builds and maintains pointers to all
     * valid SubBuilder options.
     */
    class SubBuilderFactory
    {
    public:
        /**
         * @brief Constructor. Initialize all SubBuilder members
         */
        SubBuilderFactory();

        /**
         * @brief Destructor. Delete all SubBuilder members
         */
        ~SubBuilderFactory();

        /**
         * @brief The meat of the factory. Return the appropriate SubBuilder for
         * the given tag.
         */
        SubBuilder* Get(const wxString& name);

    protected:
        /**
         * @brief A SubBuilder pointer to ARDocument Builder. 
         */
        ARDocumentBuilder* m_ardbldr;
        /**
         * @brief A SubBuilder pointer to CurveModel Builder.
         */
        CurveModelBuilder* m_curvebldr;
        /**
         * @brief A SubBuilder pointer to GridObject Builder.
         */
        GridObjectBuilder* m_gridbldr;
        /**
         * @brief A SubBuilder pointer to GroupModel Builder.
         */
        GroupModelBuilder* m_grpbldr;
        /**
         * @brief A SubBuilder pointer to LineModel Builder.
         */
        LineModelBuilder* m_linebldr;
        /**
         * @brief A SubBuilder pointer to Overlay Builder.
         */
        OverlayBuilder* m_overlaybldr;
        /**
         * @brief A SubBuilder pointer to PolyCurveModel Builder.
         */
        PolyCurveModelBuilder* m_pcurvebldr;
        /**
         * @brief A SubBuilder pointer to PolyLineModel Builder.
         */
        PolyLineModelBuilder* m_plinebldr;
        /**
         * @brief A SubBuilder pointer to Pushpin Builder.
         */
        PushpinBuilder* m_pinbldr;
        /**
         * @brief A SubBuilder pointer to ViewPoint Builder.
         */
        ViewPointBuilder* m_viewbldr;
    };

    /**
     * @brief A singleton to make sure that only one SubBuilderFactory is made/used.
     */
    class SubBuilderFactorySingleton
    {
        public:
            /**
             * @brief Get the pointer to the instance of the SubBuilderFactory.
             */
            static SubBuilderFactory* Get();

        private:
            /**
             * @brief The single allowed instance of the SubBuilderFactory.
             */
            static SubBuilderFactory* m_factory;
    };


    /********************************************************************/
    /*           Utility Routines for the SubBuilder Classes            */
    /********************************************************************/

    /** 
     * @brief Used to check and see if a given tag is a valid tag in the
     * list. Simple utility routine which may even be deleted someday.
     * 
     * @param p_tag The tag to look for
     * 
     * @return true = This is a valid tag, false = This is not a valid tag
     */
    bool isTagInList(const wxString& p_tag);

    /** 
     * @brief Convert a long int to a wxColor
     *
     * The long int is assumed to be at least 24 bits long. Bits are
     * numbered from right to left, starting at 0.
     *
     *  0- 7 = Blue
     *  8-15 = Green
     * 16-23 = Red
     * 24-xx = Discarded
     *
     * @param color The long int to be converted
     * 
     * @return  The wxColor built from the long integer
     */
    wxColor LongToColor(long int color);
    
    /** 
     * @brief Convert a string to a boolean value
     *
     * If the string is "true" or "1", it will be true.
     * If the string is "false" or "0", it will be false.
     *
     * The comparison is case-insensitive.
     * 
     * @param p_data The string to convert
     * 
     * @return true/false according to the conditions above
     */
    bool StringToBool(const wxString& p_data) throw (ARInvalidBoolString);
    
    /**
     * @brief Convert a string to a vector of points (VPoints)
     * 
     * @param p_data The string to convert
     * @return The new vector of points
     */
    OverlayVector StringToOverlayVector(const wxString& p_data) throw (ARBadNumberFormat);
       
    /**
     * @brief Convert a string into an arRealPoint
     *
     * This utility routine tokenizes a string, and reads the pieces to
     * convert into an arRealPoint.
     *
     * @param p_data The string containing the numerical values to convert
     * @return The arRealPoint which is the binary representation of the string
     */
    arRealPoint StringToPoint(const wxString& p_data) throw (ARBadNumberFormat);
    
    /**
     * @brief Convert a string into an arRealRect
     * 
     * This utility routine tokenizes a string, and reads the pieces to
     * convert into an arRealRect.
     * 
     * The one special note about this is that the string must be in the
     * format "left,top,right,bottom" to preserve backwards compatibility.
     * As a result, SetRight and SetBottom are used, instead of width and
     * height member variables.
     * 
     * @param p_data The string containing the numerical values to convert
     * @return The arRealRect which is the binary representation of the string
     */
    arRealRect StringToRect(const wxString& p_data) throw (ARBadNumberFormat);
    
    
    /**
     * @brief Convert a string into an array with arRealPoint (VPoints).
     * 
     * This utility routine tokenizes a string, and reads the pieces to
     * convert into a VPoints.
     * 
     * The one special note about this is that the string must be in the
     * format "point:point:point" to preserve backwards compatibility.
     * 
     * @param p_data  The string containing the numerical values to convert.
     * @param p_count The count of points which are be expected.
     * @return The VPoints which is the binary representation of the string.
     */
    VPoints StringToVPoints(const wxString& p_data, unsigned int p_count)
                            throw (ARBadNumberFormat, ARInvalidTagException);
    
    /**
     * @brief Get the GridType from a given wxString
     * 
     * @param p_data The string to convert
     * @return The corresponding GridType
     */
    GridObjectModel::GridType StringToGridType(const wxString& p_data);

    /**
     * @brief Get the GridPenStyle from a given wxString
     * 
     * @param p_data The string to convert
     * @return The corresponding GridPenStyle
     *  enum GridPenStyle { gpsDefault = 1, gpsSingle, gpsDot, gpsDash,
     *      gpsDashDot, gpsDashDotDot, gpsBold };
     */
    GridObjectModel::GridPenStyle StringToGridPenStyle(const wxString& p_data);

    /**
     * @brief Process all of the standard tags which appear on a DrawnObjectModel.
     *
     * @param p_obj The DrawnObjectModel to have the tag processed
     * @param p_tag The tag to process
     * @param p_data The data for the tag
     * @return true if the tag was processed, false if no action taken
     */
    bool ProcessTag(DrawnObjectModel* p_obj, wxString p_tag, wxString p_data);
    
    /**
     * @brief Get a pointer to the appropriate builder object for a given
     * tag name.
     * 
     * This method also needs to know the document pointer, to make sure
     * that all sub builders get it, so that any subbuilder which needs it
     * has it available.
     * 
     * @param p_name The name of the tag to be checked.
     * @param p_doc The pointer to the document which is being built.
     * 
     * @return The BuilderStackEntry which was built for this tag.
     */
    BuilderStackEntry getBuilder(wxString p_name, ARDocument* p_doc);
    
    /**
     * @brief Utility routine, used to print out the current stack of
     * builders (bldrstack), along with info about the entries
     */
    void printStack();
    
    /**
     * @brief Utility routine used for/during debugging. Prints out the
     * m_extraData member.
     * 
     * @param p_obj The object to be examined.
     */
    void printExtraData(ObjectInterface* p_obj);    

}   // namespace subbuilderComponents


#endif // SUB_BUILDER_H
