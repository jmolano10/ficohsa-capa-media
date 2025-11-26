(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns2:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$solicitudAperturaCuenta" element="ns1:solicitudAperturaCuenta" location="../xsd/solicitudAperturaCuentaTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:CrearCuentaSimplificada" location="../../../../Business_Resources/ConsultasCuenta/Resources/XMLSchema_378991004.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/solicitudAperturaCuentaTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/SolicitudAperturaCuenta/xq/creaCuentaClienteIn/";

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

declare function xf:creaCuentaClienteIn($requestHeader as element(ns2:RequestHeader),
    $solicitudAperturaCuenta as element(ns1:solicitudAperturaCuenta))
    as element(ns0:CrearCuentaSimplificada) {
        <ns0:CrearCuentaSimplificada>
            <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($requestHeader/Authentication/UserName)), 
												data($requestHeader/Authentication/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($requestHeader/Authentication/UserName)),
                								data($requestHeader/Authentication/Password)) }</password>
            </WebRequestCommon>
            <OfsFunction>
                <noOfAuth>0</noOfAuth>
            </OfsFunction>
            <ACCOUNTFICOINDSBWSType>
                <CustomerID>{ data($solicitudAperturaCuenta/ACCOUNT_DETAILS/ACCOUNT_DETAIL[1]/CUSTOMER_CODE) }</CustomerID>
                <Productcode>{ data($solicitudAperturaCuenta/ACCOUNT_DETAILS/ACCOUNT_DETAIL[1]/CATEGORY) }</Productcode>
                <Currency>{ data($solicitudAperturaCuenta/ACCOUNT_DETAILS/ACCOUNT_DETAIL[1]/CURRENCY) }</Currency>
                <gOTHEROFFICER>
                    <Agency>{ data($solicitudAperturaCuenta/BRANCH_CODE) }</Agency>
                </gOTHEROFFICER>
                <PassbookYN>{ data($solicitudAperturaCuenta/ACCOUNT_DETAILS/ACCOUNT_DETAIL[1]/PASSBOOK) }</PassbookYN>
                {
                    for $PASSBOOK_NUMBER in $solicitudAperturaCuenta/ACCOUNT_DETAILS/ACCOUNT_DETAIL[1]/PASSBOOK_NUMBER
                    return
                        <PASSBOOKNUMBER>{ data($PASSBOOK_NUMBER) }</PASSBOOKNUMBER>
                }
                <INITIALDEPOSIT>{ data($solicitudAperturaCuenta/ACCOUNT_DETAILS/ACCOUNT_DETAIL[1]/INITIAL_DEPOSIT) }</INITIALDEPOSIT>
                <REGISTEREDSIGN>{ data($solicitudAperturaCuenta/ACCOUNT_DETAILS/ACCOUNT_DETAIL[1]/SIGNATORY_DETAILS/REGISTERED_SIGNATORY) }</REGISTEREDSIGN>
                <REQUIREDSIGN>{ data($solicitudAperturaCuenta/ACCOUNT_DETAILS/ACCOUNT_DETAIL[1]/SIGNATORY_DETAILS/REQUIRED_SIGNATORY) }</REQUIREDSIGN>
                <gLR.PURPOSE>
                    <LRPURPOSE>{ data($solicitudAperturaCuenta/ACCOUNT_DETAILS/ACCOUNT_DETAIL[1]/PURPOSE) }</LRPURPOSE>
                </gLR.PURPOSE>
                <gLR.ORG.OF.FUNDS>
                    <LRORGOFFUNDS>{ data($solicitudAperturaCuenta/ACCOUNT_DETAILS/ACCOUNT_DETAIL[1]/ORIGEN_OF_FUNDS) }</LRORGOFFUNDS>
                </gLR.ORG.OF.FUNDS>
                <LRMONTXVOL>{ data($solicitudAperturaCuenta/ACCOUNT_DETAILS/ACCOUNT_DETAIL[1]/MONTHLY_TXN_VOLUME) }</LRMONTXVOL>
                {
                    for $OPERATION_TYPE in $solicitudAperturaCuenta/ACCOUNT_DETAILS/ACCOUNT_DETAIL[1]/OPERATION_TYPE
                    return
                        <LROPRTTYPE>{ data($OPERATION_TYPE) }</LROPRTTYPE>
                }
                {
                    let $BENEFICIARY_DETAILS := $solicitudAperturaCuenta/ACCOUNT_DETAILS/ACCOUNT_DETAIL[1]/BENEFICIARY_DETAILS
                    return
                        <gLR.BEN.NAME>
                            {
                                for $BENEFICIARY_DETAIL in $BENEFICIARY_DETAILS/BENEFICIARY_DETAIL
                                return
                                    <mLR.BEN.NAME>
                                        <LRBENNAME>{ data($BENEFICIARY_DETAIL/BENEFICIARY_NAME) }</LRBENNAME>
                                        <LRBENRELN>{ data($BENEFICIARY_DETAIL/RELATION) }</LRBENRELN>
                                        <LRBENPRG>{ data($BENEFICIARY_DETAIL/BENEFICIARY_PERCENTAGE) }</LRBENPRG>
                                    </mLR.BEN.NAME>
                            }
                        </gLR.BEN.NAME>
                }
                <ADDRESSTYPE>{ data($solicitudAperturaCuenta/ACCOUNT_DETAILS/ACCOUNT_DETAIL[1]/ADDRESS_TYPE) }</ADDRESSTYPE>
                <LRFICOREFTYP>{ data($solicitudAperturaCuenta/ACCOUNT_DETAILS/ACCOUNT_DETAIL[1]/REFERRED_TYPE) }</LRFICOREFTYP>
                <gLR.TIN.ACT>
                    <mLR.TIN.ACT>
                        <LRTINACT>{ data($solicitudAperturaCuenta/ACCOUNT_DETAILS/ACCOUNT_DETAIL[1]/BENEFICIARY_DETAILS/BENEFICIARY_DETAIL[1]/LEGAL_ID) }</LRTINACT>
                        <LRNUMACT>{ data($solicitudAperturaCuenta/ACCOUNT_DETAILS/ACCOUNT_DETAIL[1]/BENEFICIARY_DETAILS/BENEFICIARY_DETAIL[1]/DOCUMENT_TYPE) }</LRNUMACT>
                    </mLR.TIN.ACT>
                </gLR.TIN.ACT>
                <LRCUSREP>NO</LRCUSREP>
            </ACCOUNTFICOINDSBWSType>
        </ns0:CrearCuentaSimplificada>
};

declare variable $requestHeader as element(ns2:RequestHeader) external;
declare variable $solicitudAperturaCuenta as element(ns1:solicitudAperturaCuenta) external;

xf:creaCuentaClienteIn($requestHeader,
    $solicitudAperturaCuenta)
