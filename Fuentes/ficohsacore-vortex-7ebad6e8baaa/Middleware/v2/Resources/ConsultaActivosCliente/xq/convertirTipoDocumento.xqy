xquery version "2004-draft" encoding "Cp1252";

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaActivosCliente/xq/convertirTipoDocumento/";

declare function obtenerXMLDocumentos()
    as element(*){
    	<LEGAL_ID_TYPES>
			<LEGAL_ID_TYPE name="CEDULA">CC</LEGAL_ID_TYPE>
			<LEGAL_ID_TYPE name="NIT" >NIT</LEGAL_ID_TYPE>
			<LEGAL_ID_TYPE name="PASAPORTE" >PAS</LEGAL_ID_TYPE>
			<LEGAL_ID_TYPE name="CARNET DE RESIDENTE">CAR</LEGAL_ID_TYPE>
			<LEGAL_ID_TYPE name="CARNET">CAR</LEGAL_ID_TYPE>
			<LEGAL_ID_TYPE name="RUC">NIT</LEGAL_ID_TYPE>
		</LEGAL_ID_TYPES>
    };

declare function xf:convertirTipoDocumento($tipoDocumento as xs:string)
    as xs:string {
        let $codEquivalente := string(obtenerXMLDocumentos()/LEGAL_ID_TYPE[ @name=$tipoDocumento ]/text())
				return
					if($codEquivalente != '')then(
						$codEquivalente
					)else(
						$tipoDocumento
					)
};

declare variable $tipoDocumento as xs:string external;

xf:convertirTipoDocumento($tipoDocumento)