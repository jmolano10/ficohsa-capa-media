xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns3="T24WebServicesImpl";
(:: import schema at "../../../../ProviderServices/XSD/PayRemittances/XMLSchema_-1855765488.xsd" ::)
declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/payRemittancesTypes";
(:: import schema at "../../../../../MWBanking/Remittances/RequestorServices/XSD/payRemittancesTypes.xsd" ::)
declare namespace ns2="http://xmlns.oracle.com/pcbpel/adapter/db/sp/ConsultaRelConPagoBS";
(:: import schema at "../../../../ProviderServices/XSD/PayRemittances/ConsultaRelConPagoBS_sp.xsd" ::)

declare namespace xq="http://www.w3.org/2005/xquery-local-functions";
declare namespace con = "http://www.bea.com/wli/sb/services/security/config";

declare variable $userName as xs:string external;
declare variable $creditAccount as xs:string external;
declare variable $uuid as xs:string external;
declare variable $password as xs:string external;
declare variable $pagoRemesas as element() (:: schema-element(ns1:pagoRemesas) ::) external;
declare variable $outputParameters as element() (:: schema-element(ns2:OutputParameters) ::) external;


(: Función encargada de realizar el mapeo de usuario:)
declare function xq:getUsername ($LDAPUsername as xs:string)  as xs:string { 
	let $data := fn-bea:lookupBasicCredentials(concat("CommonResources/Security/", upper-case($LDAPUsername)))
  		return
		    $data/con:username/text()
 };

(: Función encargada de realizar el mapeo de contraseña:)
declare function xq:getPassword ($LDAPUsername as xs:string)  as xs:string {      
	let $data := fn-bea:lookupBasicCredentials(concat("CommonResources/Security/", upper-case($LDAPUsername)))
  		return
		    $data/con:password/text()
 };

declare function xq:pagoRemesaT24In($userName as xs:string, 
                                    $creditAccount as xs:string, 
                                    $uuid as xs:string, 
                                    $password as xs:string,
                                    $pagoRemesas as element() (:: schema-element(ns1:pagoRemesas) ::), 
                                    $outputParameters as element() (:: schema-element(ns2:OutputParameters) ::)) 
                                    as element() (:: schema-element(ns3:PagoderemesaFT) ::) {
    <ns3:PagoderemesaFT>
        <WebRequestCommon>
            <userName>{ fn-bea:fail-over( xq:getUsername(data($userName)),data($userName)) }</userName>
            <password>{ fn-bea:fail-over( xq:getPassword(data($userName)),data($password)) }</password>
        </WebRequestCommon>
        <OfsFunction>
            <messageId>{ $uuid }</messageId>
            <noOfAuth>1</noOfAuth>
        </OfsFunction>
        <FUNDSTRANSFERFICOLATAMAGINWREMPAYType>
            <DEBITTHEIRREF>{ fn:string($outputParameters/ns2:PV_PAISORIGEN/text()) }</DEBITTHEIRREF>
            <CREDITTHEIRREF>{ data($pagoRemesas/ns1:REFERENCE_NUMBER) }</CREDITTHEIRREF>
            <CREDITACCOUNT>{ $creditAccount }</CREDITACCOUNT>
                {
                    for $PV_MONEDA in $outputParameters/ns2:PV_MONEDA
                    return
                        <CREDITCURRENCY>{ data($PV_MONEDA) }</CREDITCURRENCY>
                }
            <CREDITAMOUNT>{ data($outputParameters/ns2:PN_MONTOLOCAL) }</CREDITAMOUNT>
            <LRINVOICEDT>{ fn-bea:fail-over(fn-bea:dateTime-to-string-with-format("yyyyMMdd",data($outputParameters/ns2:PD_FECHAREMESA)),"") }</LRINVOICEDT>
            <LRPARTIALAMT>{ fn:string($outputParameters/ns2:PN_TASACAMBIO/text()) }</LRPARTIALAMT>
            <LRIDENCODE>{ data($pagoRemesas/ns1:BENEFICIARY_INFO/ns1:ID) }</LRIDENCODE>
                 {
                	let $PN_MONTOLOCAL := fn:string($outputParameters/ns2:PN_MONTOLOCAL/text()) 
                	let $PN_TASACAMBIO  := fn:string($outputParameters/ns2:PN_TASACAMBIO/text()) 
                	let $pn_montoOriginal := fn-bea:decimal-round(xs:decimal($PN_MONTOLOCAL) div xs:decimal($PN_TASACAMBIO),2)
                	return
                   	if ($PN_TASACAMBIO != "1" ) then (		                	               
	                		<LRTOTTAXDUE>{ $pn_montoOriginal }</LRTOTTAXDUE>
	                ) else (
	                		<LRTOTTAXDUE>{ $PN_MONTOLOCAL }</LRTOTTAXDUE>
	                )
                } 
            <LRAGCLIENTID>{ data($pagoRemesas/ns1:REMITTER_ID) }</LRAGCLIENTID>
            <LRREMITTID>{ data($pagoRemesas/ns1:REMITTANCE_ID) }</LRREMITTID>
            <LRORDNAME>{ fn:string($outputParameters/ns2:PV_REMITENTE/text()) }</LRORDNAME>
            <LRBENNAME>{ fn:string($outputParameters/ns2:PV_BENEFICIARIO/text()) }</LRBENNAME>
            <LRDATEBIRTH>{ fn:string($pagoRemesas/ns1:BENEFICIARY_INFO/ns1:ID_ISSUE_DATE/text()) }</LRDATEBIRTH>
            <LRIDENTYPE>{ data($pagoRemesas/ns1:BENEFICIARY_INFO/ns1:ID_TYPE) }</LRIDENTYPE>
            <LRREMITMOBILE>{ data($pagoRemesas/ns1:BENEFICIARY_INFO/ns1:PHONE_NUMBER) }</LRREMITMOBILE>
            <LRCOUNTRY></LRCOUNTRY>
            <LRCITY>{ data($pagoRemesas/ns1:BENEFICIARY_INFO/ns1:CITY) }</LRCITY>
            <LRSTATE>{ data($pagoRemesas/ns1:BENEFICIARY_INFO/ns1:STATE) }</LRSTATE>
            <gLROCCUPATION>
                <LROCCUPATION>{ fn:string($pagoRemesas/ns1:BENEFICIARY_INFO/ns1:OCCUPATION/text()) }</LROCCUPATION>
            </gLROCCUPATION>
            <LRDATEOFBIR>{ fn:string($pagoRemesas/ns1:BENEFICIARY_INFO/ns1:DATE_OF_BIRTH/text()) }</LRDATEOFBIR>
                {
                let $Genero := fn:string($pagoRemesas/ns1:BENEFICIARY_INFO/ns1:GENDER/text())
                return
                if ($Genero = "M" ) then (
                    <LRGENDER>01</LRGENDER>
                ) else if ($Genero = "F") then(
                    <LRGENDER>02</LRGENDER>
                )else(
                	<LRGENDER></LRGENDER>
                )                
                }
                {
                    for $INCOME_SOURCE in $pagoRemesas/ns1:BENEFICIARY_INFO/ns1:INCOME_SOURCE
                    return
                        <SRCOFINCOME>{ data($INCOME_SOURCE) }</SRCOFINCOME>
                }
            <gADDRESS.TYPE>
                <mADDRESS.TYPE>
                    <ADDRESSTYPE>{ data($pagoRemesas/ns1:BENEFICIARY_INFO/ns1:ADDRESS_TYPE) }</ADDRESSTYPE>
                    <COUNTRYCODE>{ data($pagoRemesas/ns1:BENEFICIARY_INFO/ns1:COUNTRY) }</COUNTRYCODE>
                    <STATECODE>{ data($pagoRemesas/ns1:BENEFICIARY_INFO/ns1:STATE) }</STATECODE>
                    <CITYCODE>{ data($pagoRemesas/ns1:BENEFICIARY_INFO/ns1:CITY) }</CITYCODE>
                    <COLONYCODE>{ data($pagoRemesas/ns1:BENEFICIARY_INFO/ns1:NEIGHBORHOOD) }</COLONYCODE>
                </mADDRESS.TYPE>
            </gADDRESS.TYPE>
            <gTELEPHONE.REFER>
                <TELEPHONEREFER>{ data($pagoRemesas/ns1:BENEFICIARY_INFO/ns1:PHONE_TYPE) }</TELEPHONEREFER>
            </gTELEPHONE.REFER>
            <LRNOMTERCERO></LRNOMTERCERO>
            <LRIDUSERFN>{ data($pagoRemesas/ns1:BENEFICIARY_INFO/ns1:THIRDPARTY_INFO/ns1:ID) }</LRIDUSERFN>
            <LRNAMEUSERFN>{ data($pagoRemesas/ns1:BENEFICIARY_INFO/ns1:THIRDPARTY_INFO/ns1:NAME) }</LRNAMEUSERFN>
            <RELWTHPERREF>{ data($pagoRemesas/ns1:BENEFICIARY_INFO/ns1:THIRDPARTY_INFO/ns1:RELATIONSHIP) }</RELWTHPERREF>
            <LRTENGOAGEN>{ data($pagoRemesas/ns1:BRANCHCODE) }</LRTENGOAGEN>
            <LRTENGOUSE>{ data($pagoRemesas/ns1:TELLERID) }</LRTENGOUSE>
        </FUNDSTRANSFERFICOLATAMAGINWREMPAYType>
    </ns3:PagoderemesaFT>
};

xq:pagoRemesaT24In($userName, $creditAccount, $uuid,$password, $pagoRemesas, $outputParameters)
