(:: pragma bea:global-element-return element="ns0:InputParameters" location="../xsd/SaveLogsDB_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/SaveLogsDB";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/general/SaveLogs_DB_Server/xlst/SaveLogsDb/";

declare function xf:SaveLogsDb($PV_UUID as xs:string
								, $PV_TIPOMENSAJE as xs:string
								, $PV_IDSERVICIO as xs:string
								, $PV_IDOPERACION as xs:string
								, $PV_IDOSB as xs:string
								, $PV_BANCOORIGEN as xs:string
								, $PV_BANCODESTINO as xs:string
								, $PV_USUARIO as xs:string
								, $PC_CONTENIDO as xs:string
								, $PV_IDTXN as xs:string
								, $PV_RESULTADO as xs:string
								, $PV_MENSAJEERROR as xs:string
								, $PV_UUIDREQ as xs:string
								, $PD_FECHATXN as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_UUID>{ $PV_UUID }</ns0:PV_UUID>
            <ns0:PV_TIPOMENSAJE>{ $PV_TIPOMENSAJE }</ns0:PV_TIPOMENSAJE>
            <ns0:PV_IDSERVICIO>{ $PV_IDSERVICIO }</ns0:PV_IDSERVICIO>
            <ns0:PV_IDOPERACION>{ $PV_IDOPERACION }</ns0:PV_IDOPERACION>
            <ns0:PV_IDOSB>{ $PV_IDOSB }</ns0:PV_IDOSB>
            <ns0:PV_BANCOORIGEN>{ $PV_BANCOORIGEN }</ns0:PV_BANCOORIGEN>
            <ns0:PV_BANCODESTINO>{ $PV_BANCODESTINO }</ns0:PV_BANCODESTINO>
            <ns0:PV_USUARIO>{ $PV_USUARIO }</ns0:PV_USUARIO>
            <ns0:PC_CONTENIDO>{ $PC_CONTENIDO }</ns0:PC_CONTENIDO>
            <ns0:PV_IDTXN>{ $PV_IDTXN }</ns0:PV_IDTXN>
            <ns0:PV_RESULTADO>{ $PV_RESULTADO }</ns0:PV_RESULTADO>
            <ns0:PV_MENSAJEERROR>{ $PV_MENSAJEERROR }</ns0:PV_MENSAJEERROR>
            <ns0:PV_UUIDREQ>{ $PV_UUIDREQ }</ns0:PV_UUIDREQ>
            <ns0:PD_FECHATXN>{ $PD_FECHATXN }</ns0:PD_FECHATXN>
        </ns0:InputParameters>
};

declare variable $PV_UUID as xs:string external;
declare variable $PV_TIPOMENSAJE as xs:string external;
declare variable $PV_IDSERVICIO as xs:string external;
declare variable $PV_IDOPERACION as xs:string external;
declare variable $PV_IDOSB as xs:string external;
declare variable $PV_BANCOORIGEN as xs:string external;
declare variable $PV_BANCODESTINO as xs:string external;
declare variable $PV_USUARIO as xs:string external;
declare variable $PC_CONTENIDO as xs:string external;
declare variable $PV_IDTXN as xs:string external;
declare variable $PV_RESULTADO as xs:string external;
declare variable $PV_MENSAJEERROR as xs:string external;
declare variable $PV_UUIDREQ as xs:string external;
declare variable $PD_FECHATXN as xs:string external;

xf:SaveLogsDb($PV_UUID
				,$PV_TIPOMENSAJE
				,$PV_IDSERVICIO
				,$PV_IDOPERACION
				,$PV_IDOSB
				,$PV_BANCOORIGEN
				,$PV_BANCODESTINO
				,$PV_USUARIO
				,$PC_CONTENIDO
				,$PV_IDTXN
				,$PV_RESULTADO
				,$PV_MENSAJEERROR
				,$PV_UUIDREQ
				,$PD_FECHATXN)