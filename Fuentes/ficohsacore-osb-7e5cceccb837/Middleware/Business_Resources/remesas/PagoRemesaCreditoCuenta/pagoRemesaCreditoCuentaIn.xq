(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader" element="ns2:AutenticacionRequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$pagoRemesaCreditoCuenta" element="ns1:pagoRemesaCreditoCuenta" location="pagoRemesaCreditoCuentaTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultadedetallesdelacuentaResponse" element="ns0:ConsultadedetallesdelacuentaResponse" location="../../ConsultasCuenta/Resources/XMLSchema_378991004.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Pagoderemesaconcredacuenta" location="../Resoruces/XMLSchema_-1855765488.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagoRemesaCreditoCuentaTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/remesas/PagoRemesaCreditoCuenta/pagoRemesaCreditoCuentaIn/";

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
declare function local:set-decimal($val as xs:string,$d as xs:integer ) as xs:string
{
	let $t := fn:tokenize($val,"\.")	
	return
	if (fn:string-length($t[1]) > 0 ) then
		if (fn:string-length($t[2]) > 0 ) then
			fn:concat($t[1],".",fn:substring($t[2],1,$d))  
		else   	
			(fn:concat($t[1],".00"))		
	else
	   (fn:concat($t[1],""))
};

declare function xf:pagoRemesaCreditoCuentaIn($autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader),
    $pagoRemesaCreditoCuenta as element(ns1:pagoRemesaCreditoCuenta),
    $consultadedetallesdelacuentaResponse as element(ns0:ConsultadedetallesdelacuentaResponse),
    $contratoUsuario as xs:string)
    as element(ns0:Pagoderemesaconcredacuenta) {
        <ns0:Pagoderemesaconcredacuenta>
            <WebRequestCommon>
                <userName>
                    {
                        fn-bea:fail-over( getUsername(data($autenticacionRequestHeader/UserName)),
                        data($autenticacionRequestHeader/UserName))
                    }
				</userName>
                <password>
                    {
                        fn-bea:fail-over( getPassword(data($autenticacionRequestHeader/UserName)),
                        data($autenticacionRequestHeader/Password))
                    }
				</password>
            </WebRequestCommon>
            <OfsFunction>
                <noOfAuth>0</noOfAuth>
            </OfsFunction>
            <FUNDSTRANSFERREMITACVERINWWSType>
                <BENACCOUNTNUMBER>{ data($pagoRemesaCreditoCuenta/ACCOUNT_NUMBER) }</BENACCOUNTNUMBER>
                <CURRENCY>{ data($pagoRemesaCreditoCuenta/CURRENCY) }</CURRENCY>
                <REMITTANCEAMOUNT>{ local:set-decimal(data($pagoRemesaCreditoCuenta/AMOUNT),2) }</REMITTANCEAMOUNT>
                <LRINVOICEDT>{ data($pagoRemesaCreditoCuenta/REMITTANCE_DATE) }</LRINVOICEDT>
                <LRPARTIALAMT>{ local:set-decimal(data($pagoRemesaCreditoCuenta/REF_EXCHANGE_RATE),4) }</LRPARTIALAMT>
                {
                    for $LEGALID in $consultadedetallesdelacuentaResponse/WSACCOUNTLISTType[1]/gWSACCOUNTLISTDetailType/mWSACCOUNTLISTDetailType[1]/LEGALID
                    return
                        <LRIDENCODE>{ data($LEGALID) }</LRIDENCODE>
                }
                <LRTOTTAXDUE>{ local:set-decimal(data($pagoRemesaCreditoCuenta/REF_AMOUNT),2) }</LRTOTTAXDUE>
                <LRAGCLIENTID>{ $contratoUsuario }</LRAGCLIENTID>
                <LRREMITTID>{ data($pagoRemesaCreditoCuenta/REMITTANCE_ID) }</LRREMITTID>
                <LRORDNAME>{ fn:replace(data($pagoRemesaCreditoCuenta/REMITTER_NAME),",","") }</LRORDNAME>
                <LRBENNAME>{ fn:replace(data($pagoRemesaCreditoCuenta/BENEFICIARY_NAME),",","") }</LRBENNAME>
                {
                    for $LEGALIDTYPE in $consultadedetallesdelacuentaResponse/WSACCOUNTLISTType[1]/gWSACCOUNTLISTDetailType/mWSACCOUNTLISTDetailType[1]/LEGALIDTYPE
                    return
                        <LRIDENTYPE>{ data($LEGALIDTYPE) }</LRIDENTYPE>
                }
                <gLRREMITADD>
                    <LRREMITADD>{ fn:replace(data($pagoRemesaCreditoCuenta/REMITTER_ADDRESS),",","") }</LRREMITADD>
                </gLRREMITADD>
                <LRREMITMOBILE>{ fn:replace(data($pagoRemesaCreditoCuenta/BENEF_PHONE_NUMBER),",","") }</LRREMITMOBILE>
                <LRCOUNTRY>{ data($pagoRemesaCreditoCuenta/COUNTRY_OF_ORIGIN) }</LRCOUNTRY>
                <LRCITY>{ data($pagoRemesaCreditoCuenta/CITY_OF_ORIGIN) }</LRCITY>
                <LRSTATE>{ data($pagoRemesaCreditoCuenta/STATE_OF_ORIGIN) }</LRSTATE>
            </FUNDSTRANSFERREMITACVERINWWSType>
        </ns0:Pagoderemesaconcredacuenta>
};

declare variable $autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader) external;
declare variable $pagoRemesaCreditoCuenta as element(ns1:pagoRemesaCreditoCuenta) external;
declare variable $consultadedetallesdelacuentaResponse as element(ns0:ConsultadedetallesdelacuentaResponse) external;
declare variable $contratoUsuario as xs:string external;

xf:pagoRemesaCreditoCuentaIn($autenticacionRequestHeader,
    $pagoRemesaCreditoCuenta,
    $consultadedetallesdelacuentaResponse,
    $contratoUsuario)