(:: pragma bea:global-element-parameter parameter="$consultademunicipiosResponse" element="ns0:ConsultademunicipiosResponse" location="../../../../Business_Resources/direcciones/Resources/XMLSchema_1123420404.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaMunicipiosResponse" location="../../../../Business_Resources/direcciones/ConsultaDepartamentos/consultaDepartamentosTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaMunicipiosTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaMunicipios/xq/consultaMunicipiosOut/";

declare function xf:consultaMunicipiosOut($consultademunicipiosResponse as element(ns0:ConsultademunicipiosResponse))
    as element(ns1:consultaMunicipiosResponse) {
        <ns1:consultaMunicipiosResponse>
            <ns1:consultaMunicipiosResponseType>
                {
                    for $mWSCITYLISTDetailType in $consultademunicipiosResponse/WSCITYLISTType[1]/gWSCITYLISTDetailType/mWSCITYLISTDetailType
                    return
                        <ns1:consultaMunicipiosResponseRecordType>
                            {
                                for $ID in $mWSCITYLISTDetailType/ID
                                return
                                    <CITY_CODE>{ fn:tokenize($ID, "\.")[3] }</CITY_CODE>
                            }
                            {
                                for $DESCRIPTION in $mWSCITYLISTDetailType/DESCRIPTION
                                return
                                    <CITY_NAME>{ data($DESCRIPTION) }</CITY_NAME>
                            }
                            {
                                for $STATE in $mWSCITYLISTDetailType/STATE
                                return
                                    <DEPT_CODE>{ fn:tokenize($STATE, "\.")[2] }</DEPT_CODE>
                            }
                            {
                                for $COUNTRY in $mWSCITYLISTDetailType/COUNTRY
                                return
                                    <COUNTRY_CODE>{ data($COUNTRY) }</COUNTRY_CODE>
                            }
                        </ns1:consultaMunicipiosResponseRecordType>
                }
            </ns1:consultaMunicipiosResponseType>
        </ns1:consultaMunicipiosResponse>
};

declare variable $consultademunicipiosResponse as element(ns0:ConsultademunicipiosResponse) external;

xf:consultaMunicipiosOut($consultademunicipiosResponse)