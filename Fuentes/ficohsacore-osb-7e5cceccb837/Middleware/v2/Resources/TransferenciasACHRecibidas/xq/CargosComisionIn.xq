(:: pragma bea:global-element-parameter parameter="$ACHRequestHeader" element="ns0:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:local-element-parameter parameter="$tRANSACTION_DETAIL" type="ns1:transferenciasACHRecibidas/TRANSACTION_DETAILS/TRANSACTION_DETAIL" location="../xsd/transferenciasACHRecibidasTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns2:CobroGenericodeComision" location="../../../BusinessServices/T24/cargos/xsd/XMLSchema_-287371079.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns2 = "T24WebServicesImpl";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/transferenciasACHRecibidasTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/TransferenciasACHRecibidas/xq/CargosComisionIn/";

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

declare function xf:CargosComisionIn($ACHRequestHeader as element(ns0:RequestHeader),
    $CodigoComision as xs:string,
    $tRANSACTION_DETAIL as element(),
    $ReferenciaTxnCuentas as xs:string,
    $Descripcion as xs:string)
    as element(ns2:CobroGenericodeComision) {
        <ns2:CobroGenericodeComision>
            <WebRequestCommon>
                <userName>
                    {
                        fn-bea:fail-over( getUsername(data($ACHRequestHeader/Authentication/UserName)),
                        data($ACHRequestHeader/Authentication/UserName))
                    }
				</userName>
                <password>
                    {
                        fn-bea:fail-over( getPassword(data($ACHRequestHeader/Authentication/UserName)),
                        data($ACHRequestHeader/Authentication/Password))
                    }
				</password>
            </WebRequestCommon>
            <OfsFunction>
                <noOfAuth>0</noOfAuth>
            </OfsFunction>
            <ACCHARGEREQUESTBOOKWSType id="">
                <RequestTypeBOOK>BOOK</RequestTypeBOOK>
                <DebitAccount>{ data($tRANSACTION_DETAIL/DESTINATION) }</DebitAccount>
                <gCHARGECODE>
                    <mCHARGECODE>
                        <ChargeCode>{ $CodigoComision }</ChargeCode>
                    </mCHARGECODE>
                </gCHARGECODE>
                <RelatedReference>{ $ReferenciaTxnCuentas }</RelatedReference>
                <gEXTRADETAILS>
                    <Remarks>{ $Descripcion }</Remarks>
                </gEXTRADETAILS>
            </ACCHARGEREQUESTBOOKWSType>
        </ns2:CobroGenericodeComision>
};

declare variable $ACHRequestHeader as element(ns0:RequestHeader) external;
declare variable $CodigoComision as xs:string external;
declare variable $tRANSACTION_DETAIL as element() external;
declare variable $ReferenciaTxnCuentas as xs:string external;
declare variable $Descripcion as xs:string external;

xf:CargosComisionIn($ACHRequestHeader,
    $CodigoComision,
    $tRANSACTION_DETAIL,
    $ReferenciaTxnCuentas,
    $Descripcion)