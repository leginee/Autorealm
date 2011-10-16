unit XDom2Reg;

  {$IFDEF WIN32}
    {$IFNDEF VER140}
      {$DEFINE MSWINDOWS}
    {$ENDIF}
  {$ENDIF}
  {$IFDEF WIN16}
    {$DEFINE MSWINDOWS}
  {$ENDIF}
  {$IFDEF VER140}
    {$DEFINE VER140+}
  {$ENDIF}
  {$IFDEF VER150}
    {$DEFINE VER140+}
  {$ENDIF}

interface
uses
  {$IFDEF MSWINDOWS}
    {$IFDEF VER140+} DesignIntf, DesignEditors,  // Delphi 7
    {$ELSE} DsgnIntf, {$ENDIF}
  {$ENDIF}
  {$IFDEF LINUX}
    DesignIntf, DesignEditors,
  {$ENDIF}
  XDOM_2_3_property_editor, XDOM_2_3, Classes;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('XML',[ TDomImplementation,
                             TXmlToDomParser,
                             TDtdParser,
                             TDomToXmlParser,
                             TCMToXmlParser,
                             TXmlStandardDocReader,
                             TXmlStandardDtdReader,
                             TXmlStandardDomReader,
                             TXmlStandardCMReader,
                             TXmlStandardHandler,
                             TXmlDistributor,
                             TXmlWFTestContentHandler,
                             TXmlWFTestDTDHandler,
                             TXmlDocBuilder,
                             TXmlDtdBuilder,
                             TXmlStreamBuilder ]);
  RegisterPropertyEditor(TypeInfo(TXmlHandlers),TXmlDistributor,'',THandlerListProperty);
end;

end.
