(:: pragma bea:global-element-parameter parameter="$requestHeader1" element="ns0:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$solicitudAperturaCuenta1" element="ns2:solicitudAperturaCuenta" location="../xsd/solicitudAperturaCuentaTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:AperturaDeCuenta" location="../../../../Business_Resources/ConsultasCuenta/Resources/XMLSchema_378991004.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/solicitudAperturaCuentaTypes";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/SolicitudAperturaCuenta/xq/AperturaDeCuentaIn/";

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

declare function xf:AperturaDeCuentaIn($requestHeader1 as element(ns0:RequestHeader),
    $recordName as xs:string,
    $solicitudAperturaCuenta1 as element(ns2:solicitudAperturaCuenta))
    as element(ns1:AperturaDeCuenta) {
        <ns1:AperturaDeCuenta>
            <WebRequestCommon>
                <userName>
                    {
                        fn-bea:fail-over( getUsername(data($requestHeader1/Authentication/UserName)),
                        data($requestHeader1/Authentication/UserName))
                    }
  				</userName>
                <password>
                    {
                        fn-bea:fail-over( getPassword(data($requestHeader1/Authentication/UserName)),
                        data($requestHeader1/Authentication/Password))
                    }
				</password>
            </WebRequestCommon>
            <OfsFunction>
                <noOfAuth>0</noOfAuth>
            </OfsFunction>
            <FICOBULKAPPRCLNTINPUTACCTWSType id = "{ $recordName }">
                <CATEGORY>{ data($solicitudAperturaCuenta1/ACCOUNT_DETAILS/ACCOUNT_DETAIL[1]/CATEGORY) }</CATEGORY>
                <CURRENCY>{ data($solicitudAperturaCuenta1/ACCOUNT_DETAILS/ACCOUNT_DETAIL[1]/CURRENCY) }</CURRENCY>
                <CUSTOMER>{ data($solicitudAperturaCuenta1/ACCOUNT_DETAILS/ACCOUNT_DETAIL[1]/CUSTOMER_CODE) }</CUSTOMER>
                <LRFICOREFTYP>{ data($solicitudAperturaCuenta1/ACCOUNT_DETAILS/ACCOUNT_DETAIL[1]/REFERRED_TYPE) }</LRFICOREFTYP>
                <PASSBOOK>{ data($solicitudAperturaCuenta1/ACCOUNT_DETAILS/ACCOUNT_DETAIL[1]/PASSBOOK) }</PASSBOOK>
                <PASSBOOKNUMBER>{ data($solicitudAperturaCuenta1/ACCOUNT_DETAILS/ACCOUNT_DETAIL[1]/PASSBOOK_NUMBER) }</PASSBOOKNUMBER>
                <LRPAYROLLGRP>{ data($solicitudAperturaCuenta1/ACCOUNT_DETAILS/ACCOUNT_DETAIL[1]/PAYROLL_GROUP) }</LRPAYROLLGRP>
                <INITIALDEPOSIT>{ data($solicitudAperturaCuenta1/ACCOUNT_DETAILS/ACCOUNT_DETAIL[1]/INITIAL_DEPOSIT) }</INITIALDEPOSIT>
                <LRPURPOSE>{ data($solicitudAperturaCuenta1/ACCOUNT_DETAILS/ACCOUNT_DETAIL[1]/PURPOSE) }</LRPURPOSE>
                <LRORGOFFUNDS>{ data($solicitudAperturaCuenta1/ACCOUNT_DETAILS/ACCOUNT_DETAIL[1]/ORIGEN_OF_FUNDS) }</LRORGOFFUNDS>
                <LRMONTXVOL>{ data($solicitudAperturaCuenta1/ACCOUNT_DETAILS/ACCOUNT_DETAIL[1]/MONTHLY_TXN_VOLUME) }</LRMONTXVOL>
                <ADDRESSTYPE>{ data($solicitudAperturaCuenta1/ACCOUNT_DETAILS/ACCOUNT_DETAIL[1]/ADDRESS_TYPE) }</ADDRESSTYPE>
                <REGISTEREDSIGN>{ data($solicitudAperturaCuenta1/ACCOUNT_DETAILS/ACCOUNT_DETAIL[1]/SIGNATORY_DETAILS/REGISTERED_SIGNATORY) }</REGISTEREDSIGN>
                <REQUIREDSIGN>{ data($solicitudAperturaCuenta1/ACCOUNT_DETAILS/ACCOUNT_DETAIL[1]/SIGNATORY_DETAILS/REQUIRED_SIGNATORY) }</REQUIREDSIGN>
                <LRADDDESC>{ data($solicitudAperturaCuenta1/ACCOUNT_DETAILS/ACCOUNT_DETAIL[1]/SIGNATORY_DETAILS/SIGNATORY_DESCRIPTION) }</LRADDDESC>
                <gFIELDS81>
                    <LROPRTTYPE>{ data($solicitudAperturaCuenta1/ACCOUNT_DETAILS/ACCOUNT_DETAIL[1]/OPERATION_TYPE) }</LROPRTTYPE>
                </gFIELDS81>
                <gFIELDS82>
                {
                	for $LRSIGNID in $solicitudAperturaCuenta1/ACCOUNT_DETAILS/ACCOUNT_DETAIL/SIGNATORY_DETAILS/AUTH_SIGNATORY_DETAIL/SIGNATORY_ID
                    return
                    <LRSIGNID>{ data($LRSIGNID) }</LRSIGNID>
                }
                </gFIELDS82>
                <gFIELDS83>
                {
                	for $LRSIGNTYPE in $solicitudAperturaCuenta1/ACCOUNT_DETAILS/ACCOUNT_DETAIL/SIGNATORY_DETAILS/AUTH_SIGNATORY_DETAIL/SIGNATORY_TYPE
                    return 
                    <LRSIGNTYPE>{ data($LRSIGNTYPE) }</LRSIGNTYPE>
                }
                </gFIELDS83>
                <gFIELDS84>
                {
                	for $JOINTHOLDER in $solicitudAperturaCuenta1/ACCOUNT_DETAILS/ACCOUNT_DETAIL[1]/SIGNATORY_DETAILS/AUTH_SIGNATORY_DETAIL[1]/JOINT_HOLDER_DETAIL[1]/HOLDER_ID
                    return
                    <JOINTHOLDER>{ data($JOINTHOLDER) }</JOINTHOLDER>
                }
                </gFIELDS84>
                <gFIELDS85>
                {
                	for $RELATIONCODE in $solicitudAperturaCuenta1/ACCOUNT_DETAILS/ACCOUNT_DETAIL[1]/SIGNATORY_DETAILS/AUTH_SIGNATORY_DETAIL[1]/JOINT_HOLDER_DETAIL[1]/HOLDER_RELATION
                    return
                    <RELATIONCODE>{ data($RELATIONCODE) }</RELATIONCODE>
                }
                </gFIELDS85>
                 <gFIELDS86>
                 {
                 	  for $LRBENNAME in $solicitudAperturaCuenta1/ACCOUNT_DETAILS/ACCOUNT_DETAIL/BENEFICIARY_DETAILS/BENEFICIARY_DETAIL/BENEFICIARY_NAME
	                    return
                    	<LRBENNAME>{ data($LRBENNAME) }</LRBENNAME>
                 }
                </gFIELDS86>
                <gFIELDS87>
                {
                	  for $LRBENRELN in $solicitudAperturaCuenta1/ACCOUNT_DETAILS/ACCOUNT_DETAIL/BENEFICIARY_DETAILS/BENEFICIARY_DETAIL/RELATION
	                    return
                    <LRBENRELN>{ data($LRBENRELN) }</LRBENRELN>
                }
                </gFIELDS87>
                <gFIELDS88>
                {
	          	 	for $LRBENPRG in $solicitudAperturaCuenta1/ACCOUNT_DETAILS/ACCOUNT_DETAIL/BENEFICIARY_DETAILS/BENEFICIARY_DETAIL/BENEFICIARY_PERCENTAGE
	                return
	            	<LRBENPRG>{ data($LRBENPRG) }</LRBENPRG>
                }
                </gFIELDS88>
                <gFIELDS89>
                {
                
	          	 	for $LRTINACT in $solicitudAperturaCuenta1/ACCOUNT_DETAILS/ACCOUNT_DETAIL/BENEFICIARY_DETAILS/BENEFICIARY_DETAIL/DOCUMENT_TYPE
	                return
	            	<LRTINACT>{ data($LRTINACT) }</LRTINACT>
                }
                </gFIELDS89>
                 <gFIELDS90>
                {
	          	 	for $LRNUMACT in $solicitudAperturaCuenta1/ACCOUNT_DETAILS/ACCOUNT_DETAIL/BENEFICIARY_DETAILS/BENEFICIARY_DETAIL/LEGAL_ID
	                return
	            	<LRNUMACT>{ data($LRNUMACT) }</LRNUMACT>
                }
                </gFIELDS90>
                <USERID>{ data($solicitudAperturaCuenta1/INTERFACE_USER) }</USERID>
            </FICOBULKAPPRCLNTINPUTACCTWSType>
        </ns1:AperturaDeCuenta>
};

declare variable $requestHeader1 as element(ns0:RequestHeader) external;
declare variable $recordName as xs:string external;
declare variable $solicitudAperturaCuenta1 as element(ns2:solicitudAperturaCuenta) external;

xf:AperturaDeCuentaIn($requestHeader1,
    $recordName,
    $solicitudAperturaCuenta1)
