(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns1:OutputParameters" location="../../../BusinessServices/MasterDataPA/conDatoCuenta/xsd/conDatoCuenta_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:sjconsultaCuentaTC" location="../../../BusinessServices/SJS/consultaCuentaTC/xsd/sjconsultaCuentaTCTypes.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/conDatoCuenta";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/sjconsultaCuentaTCTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaCuentaTC/xq/sjConsultaCuentaTCPAIn/";

declare function xf:sjConsultaCuentaTCPAIn($outputParameters as element(ns1:OutputParameters), $countryCode as xs:string)
    as element(ns0:sjconsultaCuentaTC) {
        <ns0:sjconsultaCuentaTC>
            <COUNTRY_CODE>{ $countryCode }</COUNTRY_CODE>
            {
            	for $rowDatosCuenta in $outputParameters/ns1:RowSet/ns1:Row
            	return(
		            <ACCOUNT_INFORMATION>
		                <ACCOUNT_NUMBER>{ data($rowDatosCuenta/ns1:Column[@name = 'numcuenta']/text()) }</ACCOUNT_NUMBER>
		                <ORG>{ data($rowDatosCuenta/ns1:Column[@name = 'ORG']/text()) }</ORG>
		                <ORG_TYPE>{ data($rowDatosCuenta/ns1:Column[@name = 'TipoOrg']/text()) }</ORG_TYPE>
		            </ACCOUNT_INFORMATION>
		        )
	        }
        </ns0:sjconsultaCuentaTC>
};

declare variable $outputParameters as element(ns1:OutputParameters) external;
declare variable $countryCode as xs:string external;

xf:sjConsultaCuentaTCPAIn($outputParameters, $countryCode)