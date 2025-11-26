(:: pragma bea:global-element-parameter parameter="$consultaImagenFirmasResponse1" element="ns0:consultaImagenFirmasResponse" location="../../../../Middleware/Business_Resources/consultasImagen/ConsultaImagenFirmas/consultaImagenFirmasTypes.xsd" ::)
(:: pragma  parameter="$base64Array" type="anyType" ::)
(:: pragma bea:global-element-return element="ns0:consultaImagenFirmasResponse" location="../../xsds/ConsultaImagenFirmas/consultaImagenFirmasTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaImagenFirmasTypes";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/ConsultaFirmasCuenta/consultaFirmasOut3/";

declare function xf:consultaFirmasOut3($consultaImagenFirmasResponse1 as element(ns0:consultaImagenFirmasResponse),
    $base64Array as element(*))
    as element(ns0:consultaImagenFirmasResponse) {
        <ns0:consultaImagenFirmasResponse>
            {
                for $ACCOUNT_NAME in $consultaImagenFirmasResponse1/ACCOUNT_NAME
                return
                    <ACCOUNT_NAME>{ data($ACCOUNT_NAME) }</ACCOUNT_NAME>
            }
            {
                for $REQUIRED_SIGNATURE in $consultaImagenFirmasResponse1/REQUIRED_SIGNATURE
                return
                    <REQUIRED_SIGNATURE>{ data($REQUIRED_SIGNATURE) }</REQUIRED_SIGNATURE>
            }
            {
                for $REGISTERED_SIGNATURE in $consultaImagenFirmasResponse1/REGISTERED_SIGNATURE
                return
                    <REGISTERED_SIGNATURE>{ data($REGISTERED_SIGNATURE) }</REGISTERED_SIGNATURE>
            }
            {
                for $SIGNATURE_DESCRIPTION in $consultaImagenFirmasResponse1/SIGNATURE_DESCRIPTION
                return
                    <SIGNATURE_DESCRIPTION>{ data($SIGNATURE_DESCRIPTION) }</SIGNATURE_DESCRIPTION>
            }
            {
                for $consultaImagenFirmasResponseType in $consultaImagenFirmasResponse1/ns0:consultaImagenFirmasResponseType
                return
                    <ns0:consultaImagenFirmasResponseType>
                        {
                            for $consultaImagenFirmasResponseRecordType at $pos in $consultaImagenFirmasResponseType/ns0:consultaImagenFirmasResponseRecordType
                            return
                                <ns0:consultaImagenFirmasResponseRecordType>
                                    {
                                        for $SIGNATURE_TYPE in $consultaImagenFirmasResponseRecordType/SIGNATURE_TYPE
                                        return
                                            <SIGNATURE_TYPE>{ data($SIGNATURE_TYPE) }</SIGNATURE_TYPE>
                                    }
                                    {
                                        for $SIGNATURE_NAME in $consultaImagenFirmasResponseRecordType/SIGNATURE_NAME
                                        return
                                            <SIGNATURE_NAME>{ data($SIGNATURE_NAME) }</SIGNATURE_NAME>
                                    }
                                    <SIGNATURE_IMAGE>{ data($base64Array/ImagenBase64[$pos])}</SIGNATURE_IMAGE>
                                    <FILE_EXTENSION>base64</FILE_EXTENSION>
                                </ns0:consultaImagenFirmasResponseRecordType>
                        }
                    </ns0:consultaImagenFirmasResponseType>
            }
        </ns0:consultaImagenFirmasResponse>
};

declare variable $consultaImagenFirmasResponse1 as element(ns0:consultaImagenFirmasResponse) external;
declare variable $base64Array as element(*) external;

xf:consultaFirmasOut3($consultaImagenFirmasResponse1,
    $base64Array)