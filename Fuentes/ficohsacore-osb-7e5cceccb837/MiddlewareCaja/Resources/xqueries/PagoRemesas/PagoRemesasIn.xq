(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader" element="ns2:AutenticacionRequestHeader" location="../../xsds/General/Autenticacion.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$pagoRemesas" element="ns1:pagoRemesas" location="../../xsds/PagoRemesas/PagoRemesas.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaderemesaResponse" element="ns0:ConsultaderemesaResponse" location="../../xsds/Remesas/XMLSchema_-1855765488.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Pagoderemesas" location="../../xsds/Remesas/XMLSchema_-1855765488.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagoRemesasTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/PagoRemesas/PagoRemesasIn/";

declare function xf:PagoRemesasIn($autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader),
    $pagoRemesas as element(ns1:pagoRemesas),
    $consultaderemesaResponse as element(ns0:ConsultaderemesaResponse))
    as element(ns0:Pagoderemesas) {
        <ns0:Pagoderemesas>
            <WebRequestCommon>
                <userName>{ data($autenticacionRequestHeader/UserName) }</userName>
                <password>{ data($autenticacionRequestHeader/Password) }</password>
            </WebRequestCommon>
			<OfsFunction>
				<gtsControl></gtsControl>
				<messageId></messageId>
				<noOfAuth>0</noOfAuth>
				<replace></replace>
			</OfsFunction>            
            <TELLERLATAMAGINWREMITPAYWSType>
                {
                    for $CURRENCY in $consultaderemesaResponse/WSLATAMAGREMITTANCEINFOType[1]/gWSLATAMAGREMITTANCEINFODetailType/mWSLATAMAGREMITTANCEINFODetailType[1]/CURRENCY
                    return
                        <CURRENCY>{ data($CURRENCY) }</CURRENCY>
                }
                {
                    for $REMITTANCEDATE in $consultaderemesaResponse/WSLATAMAGREMITTANCEINFOType[1]/gWSLATAMAGREMITTANCEINFODetailType/mWSLATAMAGREMITTANCEINFODetailType[1]/REMITTANCEDATE
                    return
                        <LRINVOICEDT>{ data($REMITTANCEDATE) }</LRINVOICEDT>
                }
                {
                    for $EXCHANGERATE in $consultaderemesaResponse/WSLATAMAGREMITTANCEINFOType[1]/gWSLATAMAGREMITTANCEINFODetailType/mWSLATAMAGREMITTANCEINFODetailType[1]/EXCHANGERATE
                    return
                        <LRPARTIALAMT>{ data($EXCHANGERATE) }</LRPARTIALAMT>
                }
                <LRIDENCODE>{ data($pagoRemesas/BENEFICIARY_INFO/BENEF_ID) }</LRIDENCODE>
                {
                    for $SERVICEID in $consultaderemesaResponse/WSLATAMAGREMITTANCEINFOType[1]/gWSLATAMAGREMITTANCEINFODetailType/mWSLATAMAGREMITTANCEINFODetailType[1]/SERVICEID
                    return
                        <LRAGCLIENTID>{ data($SERVICEID) }</LRAGCLIENTID>
                }
                {
                    for $ORDPARTYNAME in $consultaderemesaResponse/WSLATAMAGREMITTANCEINFOType[1]/gWSLATAMAGREMITTANCEINFODetailType/mWSLATAMAGREMITTANCEINFODetailType[1]/ORDPARTYNAME
                    return
                        <LRORDNAME>{ data($ORDPARTYNAME) }</LRORDNAME>
                }
                {
                    for $BENEFICIARY in $consultaderemesaResponse/WSLATAMAGREMITTANCEINFOType[1]/gWSLATAMAGREMITTANCEINFODetailType/mWSLATAMAGREMITTANCEINFODetailType[1]/BENEFICIARY
                    return
                        <LRBENNAME>{ data($BENEFICIARY) }</LRBENNAME>
                }
                {
                    for $AMOUNT in $consultaderemesaResponse/WSLATAMAGREMITTANCEINFOType[1]/gWSLATAMAGREMITTANCEINFODetailType/mWSLATAMAGREMITTANCEINFODetailType[1]/AMOUNT
                    return
                        <LRBALDUE>{ data($AMOUNT) }</LRBALDUE>
                }
                <LRIDENTYPE>{ data($pagoRemesas/BENEFICIARY_INFO/BENEF_ID_TYPE) }</LRIDENTYPE>
                <gLRREMITADD>
                    {
                        for $BENEF_ADDRESS in $pagoRemesas/BENEFICIARY_INFO/BENEF_ADDRESS
                        return
                            <LRREMITADD>{ substring($BENEF_ADDRESS,1, 35) }</LRREMITADD>
                    }
                </gLRREMITADD>                
                <LRREMITMOBILE>{ data($pagoRemesas/BENEFICIARY_INFO/BENEF_PHONE_NUMBER) }</LRREMITMOBILE>
                <LRCOUNTRY>{ data($pagoRemesas/BENEFICIARY_INFO/BENEF_COUNTRY) }</LRCOUNTRY>
                <LRCITY>{ data($pagoRemesas/BENEFICIARY_INFO/BENEF_CITY) }</LRCITY>
                <LRREMITTID>{ data($pagoRemesas/REMITTANCE_ID) }</LRREMITTID>
                {
                    for $BENEF_ADDRESS in $pagoRemesas/BENEFICIARY_INFO/BENEF_ADDRESS
                    return
                        <LRMAPID>{ substring($BENEF_ADDRESS, 36) }</LRMAPID>
                }                
                {
                    for $BENEF_DATE_OF_BIRTH in $pagoRemesas/BENEFICIARY_INFO/BENEF_DATE_OF_BIRTH
                    return
                        <LRDATEOFBIR>{ data($BENEF_DATE_OF_BIRTH) }</LRDATEOFBIR>
                }
                <gLROCCUPATION>
                    {
                        for $BENEF_OCCUPATION in $pagoRemesas/BENEFICIARY_INFO/BENEF_OCCUPATION
                        return
                            <LROCCUPATION>{ data($BENEF_OCCUPATION) }</LROCCUPATION>
                    }
                </gLROCCUPATION>
                <LRSTATE>{ data($pagoRemesas/BENEFICIARY_INFO/BENEF_STATE) }</LRSTATE>
            </TELLERLATAMAGINWREMITPAYWSType>
        </ns0:Pagoderemesas>
};

declare variable $autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader) external;
declare variable $pagoRemesas as element(ns1:pagoRemesas) external;
declare variable $consultaderemesaResponse as element(ns0:ConsultaderemesaResponse) external;

xf:PagoRemesasIn($autenticacionRequestHeader,
    $pagoRemesas,
    $consultaderemesaResponse)