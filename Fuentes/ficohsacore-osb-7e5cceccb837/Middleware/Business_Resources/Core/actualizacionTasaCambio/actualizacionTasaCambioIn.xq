(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader" element="ns2:AutenticacionRequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$actualizacionTasaCambio" element="ns1:actualizacionTasaCambio" location="actualizacionTasaCambioTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Actualizaciondetasadecambio" location="../Resources/XMLSchema_1632682327.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/actualizacionTasaCambioTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/Core/actualizacionTasaCambio/actualizacionTasaCambioIn/";

(: Función encargada de realizar el mapeo de usuario:)
declare function getUsername ($LDAPUsername as xs:string)  as xs:string { 
	let $data := fn-bea:lookupBasicCredentials(concat("Middleware/Security/", upper-case($LDAPUsername)))
  		return
		    $data/con:username/text()
 };

(: Función encargada de realizar el mapeo de contraseña:)
declare function getPassword ($LDAPUsername as xs:string)  as xs:string {      
	let $data := fn-bea:lookupBasicCredentials(concat("Middleware/Security/", upper-case($LDAPUsername)))
  		return
		    $data/con:password/text()
 };


declare function xf:actualizacionTasaCambioIn($autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader),
    $actualizacionTasaCambio as element(ns1:actualizacionTasaCambio))
    as element(ns0:Actualizaciondetasadecambio) {
        <ns0:Actualizaciondetasadecambio>
            <WebRequestCommon>
                 <userName>{ fn-bea:fail-over( getUsername(data($autenticacionRequestHeader/UserName)), 
												data($autenticacionRequestHeader/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($autenticacionRequestHeader/UserName)),
                								data($autenticacionRequestHeader/Password)) }</password>
            </WebRequestCommon>
            <OfsFunction>
                <gtsControl/>
                <messageId/>
                <noOfAuth>0</noOfAuth>
                <replace/>
            </OfsFunction>
            <CURRENCYFICOSALPERCENTAGEType id = "{ data($actualizacionTasaCambio/CURRENCY) }">
                <gCURRENCYMARKET>
                    <mCURRENCYMARKET m = "1">
                        <CURRENCYMARKET>1</CURRENCYMARKET>
                        <BUYRATE>{ data($actualizacionTasaCambio/BUY_RATE) }</BUYRATE>
                        <SELLRATE>{ data($actualizacionTasaCambio/BUY_RATE) }</SELLRATE>
                        <REVALRATE>{ data($actualizacionTasaCambio/BUY_RATE) }</REVALRATE>
                    </mCURRENCYMARKET>
                    <mCURRENCYMARKET m = "2">
                        <CURRENCYMARKET>10</CURRENCYMARKET>
                        <BUYRATE>{ data($actualizacionTasaCambio/BUY_RATE) }</BUYRATE>
                        <SELLRATE>{ data($actualizacionTasaCambio/BUY_RATE) }</SELLRATE>
                        <REVALRATE></REVALRATE>
                    </mCURRENCYMARKET>
                    <mCURRENCYMARKET m = "3">
                        <CURRENCYMARKET>2</CURRENCYMARKET>
                        <BUYRATE>{ data($actualizacionTasaCambio/BUY_RATE) }</BUYRATE>
                        <SELLRATE>{ data($actualizacionTasaCambio/BUY_RATE) }</SELLRATE>
                        <REVALRATE>{ data($actualizacionTasaCambio/BUY_RATE) }</REVALRATE>
                    </mCURRENCYMARKET>
                </gCURRENCYMARKET>
            </CURRENCYFICOSALPERCENTAGEType>
        </ns0:Actualizaciondetasadecambio>
};

declare variable $autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader) external;
declare variable $actualizacionTasaCambio as element(ns1:actualizacionTasaCambio) external;

xf:actualizacionTasaCambioIn($autenticacionRequestHeader,
    $actualizacionTasaCambio)