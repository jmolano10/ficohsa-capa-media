(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns2:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$depositoVirtualCheques" element="ns1:depositoVirtualCheques" location="../../DepositoVirtualCheques/xsd/depositoVirtualChequesTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:RegistrarDepositoChequeVirtual" location="../../../../Business_Resources/compensacion/resources/XMLSchema_1569843523.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/depositoVirtualChequesTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/DepositoChequeVirtualPropio/xq/registrarDepositoChequeVirtualIn/";

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

declare function xf:registrarDepositoChequeVirtualIn($requestHeader as element(ns2:RequestHeader),
    $depositoVirtualCheques as element(ns1:depositoVirtualCheques),
    $calculado as xs:string,
    $chequeType as xs:string)
    as element(ns0:RegistrarDepositoChequeVirtual) {
        <ns0:RegistrarDepositoChequeVirtual>
            <WebRequestCommon>
                <userName>
                    {
                        fn-bea:fail-over( getUsername(data($requestHeader/Authentication/UserName)),
                        data($requestHeader/Authentication/UserName))
                    }
				</userName>
                <password>
                    {
                        fn-bea:fail-over( getPassword(data($requestHeader/Authentication/UserName)),
                        data($requestHeader/Authentication/Password))
                    }
				</password>
            </WebRequestCommon>
            <OfsFunction>
                <noOfAuth>0</noOfAuth>
            </OfsFunction>
            <FICOHCHEQUEVIRTUALINPUTWSType>
                <TIPOCHEQUE>{ $calculado }</TIPOCHEQUE>
                <NOCUENTADESTINO>{ data($depositoVirtualCheques/BEN_ACCOUNT) }</NOCUENTADESTINO>
                <CODCLIENTEBEN>{ data($depositoVirtualCheques/BEN_CUSTOMER_CODE) }</CODCLIENTEBEN>
                <RUTATRANSITO>{ data($depositoVirtualCheques/TRANSIT_ROUTE) }</RUTATRANSITO>
                <NOCHEQUE>{ data($depositoVirtualCheques/CHEQUE_NUMBER) }</NOCHEQUE>
                <NOCUENTAORIGEN>{ data($depositoVirtualCheques/CHEQUE_ACCOUNT) }</NOCUENTAORIGEN>
                <MONEDA>{ data($depositoVirtualCheques/CURRENCY) }</MONEDA>
                <MONTO>{ data($depositoVirtualCheques/AMOUNT) }</MONTO>
                <USUARIOCANAL>{ data($depositoVirtualCheques/USER_CODE) }</USUARIOCANAL>
                <TIPOCHQPROPIO>{ $chequeType }</TIPOCHQPROPIO>
            </FICOHCHEQUEVIRTUALINPUTWSType>
        </ns0:RegistrarDepositoChequeVirtual>
};

declare variable $requestHeader as element(ns2:RequestHeader) external;
declare variable $depositoVirtualCheques as element(ns1:depositoVirtualCheques) external;
declare variable $calculado as xs:string external;
declare variable $chequeType as xs:string external;

xf:registrarDepositoChequeVirtualIn($requestHeader,
    $depositoVirtualCheques,
    $calculado,
    $chequeType)