xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultadeclienteResponse1" element="ns0:ConsultadeclienteResponse" location="../../../../Business_Resources/consultasCliente/Resources/XMLSchema_1144838292.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaTelefonoClienteResponse" location="../xsd/consultaTelefonoClienteTypes.xsd" ::)

declare namespace ns0 = "T24WebServicesImpl";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaTelefonoClienteTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaTelefonoCliente/xq/consultaTelefonoClienteOut2/";

declare function xf:consultaTelefonoClienteOut2($consultadeclienteResponse1 as element(ns0:ConsultadeclienteResponse))
    as element(ns1:consultaTelefonoClienteResponse) {
        <ns1:consultaTelefonoClienteResponse>
            {
                for $CUSTOMER in $consultadeclienteResponse1/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/CUSTOMER
                return
                    <CUSTOMER_ID>{ data($CUSTOMER) }</CUSTOMER_ID>
            }
            <IDENTIFICATION_INFO>
                <LEGAL_IDENTIFICATION_ITEM>
                    {
                        for $LEGALDOCNAME in $consultadeclienteResponse1/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/LEGALDOCNAME
                        return
                            <LEGAL_DOCUMENT_NAME>{ data($LEGALDOCNAME) }</LEGAL_DOCUMENT_NAME>
                    }
                    <LEGAL_ID>{ data($consultadeclienteResponse1/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/LEGALID) }</LEGAL_ID>
                    {
                        for $LEGALIDENTIFICATIONEXPIRATIONDAT in $consultadeclienteResponse1/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/LEGALIDENTIFICATIONEXPIRATIONDAT
                        return
                            <EXPIRATION_DATE>{ data($LEGALIDENTIFICATIONEXPIRATIONDAT) }</EXPIRATION_DATE>
                    }
                </LEGAL_IDENTIFICATION_ITEM>
            </IDENTIFICATION_INFO>
            {
                for $GIVENNAMES in $consultadeclienteResponse1/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/GIVENNAMES
                return
                    <GIVEN_NAMES>{ data($GIVENNAMES) }</GIVEN_NAMES>
            }
            {
                for $FAMILYNAMES in $consultadeclienteResponse1/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/FAMILYNAMES
                return
                    <FAMILY_NAME>{ data($FAMILYNAMES) }</FAMILY_NAME>
            }
            {
                for $LEGALHOLDERNAME in $consultadeclienteResponse1/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/LEGALHOLDERNAME
                return
                    <FULL_NAME>{ data($LEGALHOLDERNAME) }</FULL_NAME>
            }
            <PHONE_INFO>
            {
            	let $SMS:= $consultadeclienteResponse1/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/SMS
                let $phoneNumbers:= fn:tokenize(data($SMS),'\|')
                for $i in 1 to fn:count($phoneNumbers)
                return
                	<PHONE_NUMBER_ITEM>
                    	<PHONE_LOCATION/>
                    	<PHONE_AREA_CODE>{ substring(data($phoneNumbers[$i]), 0, 4) }</PHONE_AREA_CODE>
                        <PHONE_NUMBER>{ substring(data($phoneNumbers[$i]), 4, 12) }</PHONE_NUMBER>
                        <PHONE_ORDER>{ data($i) }</PHONE_ORDER>
                	</PHONE_NUMBER_ITEM>
			 }   
            </PHONE_INFO>
            <EMAIL_INFO>
                <EMAIL_ITEM>
                    {
                        for $EMAIL in $consultadeclienteResponse1/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/EMAIL
                        return
                            <EMAIL_ADDRESS>{ data($EMAIL) }</EMAIL_ADDRESS>
                    }
                </EMAIL_ITEM>
            </EMAIL_INFO>
        </ns1:consultaTelefonoClienteResponse>
};

declare variable $consultadeclienteResponse1 as element(ns0:ConsultadeclienteResponse) external;

xf:consultaTelefonoClienteOut2($consultadeclienteResponse1)