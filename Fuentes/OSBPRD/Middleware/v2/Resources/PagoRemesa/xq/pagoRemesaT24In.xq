(:: pragma bea:global-element-parameter parameter="$requestHeader1" element="ns3:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$pagoRemesas1" element="ns2:pagoRemesas" location="../xsd/pagoRemesas.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns0:OutputParameters" location="../../../BusinessServices/consultaRelConPago/xsd/consultaRelConPago_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:PagoderemesaFT" location="../../../../Business_Resources/remesas/Resoruces/XMLSchema_-1855765488.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/pagoRemesasTypes";
declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace ns3 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaRelConPago";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagoRemesa/xq/pagoRemesaT24In/";

declare function getUsername ($LDAPUsername as xs:string)  as xs:string { 
	let $data := fn-bea:lookupBasicCredentials(concat("Middleware/Security/", upper-case($LDAPUsername)))
  		return
		    $data/con:username/text()
 };
declare function getPassword ($LDAPUsername as xs:string)  as xs:string {      
	let $data := fn-bea:lookupBasicCredentials(concat("Middleware/Security/", upper-case($LDAPUsername)))
  		return
		    $data/con:password/text()
 };
 
 declare function additional-info ($request as element(ns2:pagoRemesas))  as xs:string {  
		 if(fn:string-length($request/ADDITIONAL_INFO/INFO[NAME="NIVEL_EDUCATIVO"]/VALUE/text())>0) then (   
			let $nivelEducativoCodigo := fn:string($request/ADDITIONAL_INFO/INFO[NAME="NIVEL_EDUCATIVO"]/VALUE/text())
			let $nivelEducativo := 
				if (data($nivelEducativoCodigo) = "1") then ( "PRIMARIA") 
				else if (data($nivelEducativoCodigo) = "2") then ( "SECUNDARIA")
				else if (data($nivelEducativoCodigo) = "3") then ( "SUPERIOR")
				else if (data($nivelEducativoCodigo) = "4") then ( "POSTGRADO")
				else()
				
				return
				$nivelEducativo
				
		 )else(let $nivelEducativo := "PRIMARIA" return $nivelEducativo ) 
		 
  		
 };
 
 declare function getAge ($request as element(ns2:pagoRemesas))  as xs:string {  
			 if(fn:string-length($request/ADDITIONAL_INFO/INFO[NAME="EDAD"]/VALUE/text())>0) then (   
				   
	                let $Edad := fn:string($request/ADDITIONAL_INFO/INFO[NAME="EDAD"]/VALUE/text())
	                
	                return 
	                $Edad
	                               
	          )else(	let $Edad := "30" return $Edad)
	          
	      
 };

declare function xf:pagoRemesaT24In($requestHeader1 as element(ns3:RequestHeader),
    $pagoRemesas1 as element(ns2:pagoRemesas),
    $outputParameters1 as element(ns0:OutputParameters),
    $creditAccount as xs:string,
    $uuid as xs:string)
    as element(ns1:PagoderemesaFT) {
        <ns1:PagoderemesaFT>
            <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($requestHeader1/Authentication/UserName)), 
												data($requestHeader1/Authentitacion/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($requestHeader1/Authentication/UserName)),
                								data($requestHeader1/Authentication/Password)) }</password>
            </WebRequestCommon>
            <OfsFunction>
                <messageId>{ $uuid }</messageId>
                <noOfAuth>1</noOfAuth>
            </OfsFunction>
            <FUNDSTRANSFERFICOLATAMAGINWREMPAYType>
            	<DEBITTHEIRREF>{ fn:string($outputParameters1/ns0:PV_PAISORIGEN/text()) }</DEBITTHEIRREF>
                <CREDITTHEIRREF>{ data($pagoRemesas1/REFERENCE_NUMBER) }</CREDITTHEIRREF>
                <CREDITACCOUNT>{ $creditAccount }</CREDITACCOUNT>
                {
                    for $PV_MONEDA in $outputParameters1/ns0:PV_MONEDA
                    return
                        <CREDITCURRENCY>{ data($PV_MONEDA) }</CREDITCURRENCY>
                }
                <CREDITAMOUNT>{ data($outputParameters1/ns0:PN_MONTOLOCAL) }</CREDITAMOUNT>
                <gPAYMENTDETAILS>
                    <PAYMENTDETAILS>{   getAge($pagoRemesas1) }</PAYMENTDETAILS>
                    <PAYMENTDETAILS>{ additional-info($pagoRemesas1) }</PAYMENTDETAILS>
                </gPAYMENTDETAILS>
                <LRINVOICEDT>{ fn-bea:fail-over(fn-bea:dateTime-to-string-with-format("yyyyMMdd",data($outputParameters1/ns0:PD_FECHAREMESA)),"") }</LRINVOICEDT>
                <LRPARTIALAMT>{ fn:string($outputParameters1/ns0:PN_TASACAMBIO/text()) }</LRPARTIALAMT>
                <LRIDENCODE>{ data($pagoRemesas1/BENEFICIARY_INFO/ID) }</LRIDENCODE>
                <LRDATEBIRTH>{ data($pagoRemesas1/BENEFICIARY_INFO/ID_ISSUE_DATE) }</LRDATEBIRTH>
                 {
                	let $PN_MONTOLOCAL := fn:string($outputParameters1/ns0:PN_MONTOLOCAL/text()) 
                	let $PN_TASACAMBIO  := fn:string($outputParameters1/ns0:PN_TASACAMBIO/text()) 
                	let $pn_montoOriginal := fn-bea:decimal-round(xs:decimal($PN_MONTOLOCAL) div xs:decimal($PN_TASACAMBIO),2)
                	return
                   	if ($PN_TASACAMBIO != "1" ) then (		                	               
	                		<LRTOTTAXDUE>{ $pn_montoOriginal }</LRTOTTAXDUE>
	                ) else (
	                		<LRTOTTAXDUE>{ $PN_MONTOLOCAL }</LRTOTTAXDUE>
	                )
                }                
                <LRAGCLIENTID>{ data($pagoRemesas1/REMITTER_ID) }</LRAGCLIENTID>
                <LRREMITTID>{ data($pagoRemesas1/REMITTANCE_ID) }</LRREMITTID>
                <LRORDNAME>{ fn:string($outputParameters1/ns0:PV_REMITENTE/text()) }</LRORDNAME>
                <LRBENNAME>{ fn:string($outputParameters1/ns0:PV_BENEFICIARIO/text()) }</LRBENNAME>
                <LRIDENTYPE>{ data($pagoRemesas1/BENEFICIARY_INFO/ID_TYPE) }</LRIDENTYPE>
                <LRREMITMOBILE>{ data($pagoRemesas1/BENEFICIARY_INFO/PHONE_NUMBER) }</LRREMITMOBILE>
                <LRCITY>{ data($pagoRemesas1/BENEFICIARY_INFO/CITY) }</LRCITY>
                <LRSTATE>{ data($pagoRemesas1/BENEFICIARY_INFO/STATE) }</LRSTATE>
                <gLROCCUPATION>
                    <LROCCUPATION>{ fn:string($pagoRemesas1/BENEFICIARY_INFO/OCCUPATION/text()) }</LROCCUPATION>
                </gLROCCUPATION>
                <LRDATEOFBIR>{ fn:string($pagoRemesas1/BENEFICIARY_INFO/DATE_OF_BIRTH/text()) }</LRDATEOFBIR>
                <LRDATEBIRTH>{ fn:string($pagoRemesas1/BENEFICIARY_INFO/ID_ISSUE_DATE/text()) }</LRDATEBIRTH>
                {
                    for $INCOME_SOURCE in $pagoRemesas1/BENEFICIARY_INFO/INCOME_SOURCE
                    return
                        <SRCOFINCOME>{ data($INCOME_SOURCE) }</SRCOFINCOME>
                }
                <gADDRESS.TYPE>
                    <mADDRESS.TYPE>
                        <ADDRESSTYPE>{ data($pagoRemesas1/BENEFICIARY_INFO/ADDRESS_TYPE) }</ADDRESSTYPE>
                        <COUNTRYCODE>{ data($pagoRemesas1/BENEFICIARY_INFO/COUNTRY) }</COUNTRYCODE>
                        <STATECODE>{ data($pagoRemesas1/BENEFICIARY_INFO/STATE) }</STATECODE>
                        <CITYCODE>{ data($pagoRemesas1/BENEFICIARY_INFO/CITY) }</CITYCODE>
                        <COLONYCODE>{ data($pagoRemesas1/BENEFICIARY_INFO/NEIGHBORHOOD) }</COLONYCODE>
                    </mADDRESS.TYPE>
                </gADDRESS.TYPE>
                <gTELEPHONE.REFER>
                    <TELEPHONEREFER>{ data($pagoRemesas1/BENEFICIARY_INFO/PHONE_TYPE) }</TELEPHONEREFER>
                </gTELEPHONE.REFER>
                <LRIDUSERFN>{ data($pagoRemesas1/BENEFICIARY_INFO/THIRDPARTY_INFO/ID) }</LRIDUSERFN>
                <LRNAMEUSERFN>{ data($pagoRemesas1/BENEFICIARY_INFO/THIRDPARTY_INFO/NAME) }</LRNAMEUSERFN>
                <RELWTHPERREF>{ data($pagoRemesas1/BENEFICIARY_INFO/THIRDPARTY_INFO/RELATIONSHIP) }</RELWTHPERREF>
                {
                let $Genero := fn:string($pagoRemesas1/BENEFICIARY_INFO/GENDER/text())
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
                let $BeneficiarioFinal := fn:string($pagoRemesas1/BENEFICIARY_INFO/REMITTANCE_BENEFICIARY/text())
                return
                if ($BeneficiarioFinal != "NO" ) then (
                    <LRNOMTERCERO>NO</LRNOMTERCERO>
                    ) else (
                    <LRNOMTERCERO>SI</LRNOMTERCERO>
                    )                
                }                                       
                <LRTENGOAGEN>{ data($pagoRemesas1/BRANCHCODE) }</LRTENGOAGEN>
                <LRTENGOUSE>{ data($pagoRemesas1/TELLERID) }</LRTENGOUSE>                
            </FUNDSTRANSFERFICOLATAMAGINWREMPAYType>
        </ns1:PagoderemesaFT>
};

declare variable $requestHeader1 as element(ns3:RequestHeader) external;
declare variable $pagoRemesas1 as element(ns2:pagoRemesas) external;
declare variable $outputParameters1 as element(ns0:OutputParameters) external;
declare variable $creditAccount as xs:string external;
declare variable $uuid as xs:string external;

xf:pagoRemesaT24In($requestHeader1,
    $pagoRemesas1,
    $outputParameters1,
    $creditAccount,
    $uuid)