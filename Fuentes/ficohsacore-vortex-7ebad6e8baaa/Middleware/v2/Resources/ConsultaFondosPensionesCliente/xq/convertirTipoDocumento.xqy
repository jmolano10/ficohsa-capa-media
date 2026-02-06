xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare variable $documentType as xs:string external;

declare function local:obtenerXMLDocumentos()
    as element(*){
    	<LEGAL_ID_TYPES>
              <LEGAL_ID_TYPE name="1">CC</LEGAL_ID_TYPE>
              <LEGAL_ID_TYPE name="9" >NIT</LEGAL_ID_TYPE>
              <LEGAL_ID_TYPE name="4" >PAS</LEGAL_ID_TYPE>
              <LEGAL_ID_TYPE name="2">CAR</LEGAL_ID_TYPE>
        </LEGAL_ID_TYPES>
    };

declare function local:func($documentType as xs:string) {
        let $codEquivalente := string(local:obtenerXMLDocumentos()/LEGAL_ID_TYPE[ @name=$documentType ])
        return
        ($codEquivalente,$documentType)[. != ''][1]
};

local:func($documentType)