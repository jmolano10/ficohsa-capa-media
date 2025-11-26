(:: pragma bea:global-element-parameter parameter="$consultadedepartamentosResponse" element="ns0:ConsultadedepartamentosResponse" location="../Resources/XMLSchema_1123420404.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaDepartamentosResponse" location="consultaDepartamentosTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaDepartamentosTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/direcciones/ConsultaDepartamentos/consultaDepartamentosOut/";

declare function xf:consultaDepartamentosOut($consultadedepartamentosResponse as element(ns0:ConsultadedepartamentosResponse))
    as element(ns1:consultaDepartamentosResponse) {
        <ns1:consultaDepartamentosResponse>
            <ns1:consultaDepartamentosResponseType>
                {
                    for $mWSSTATELISTDetailType in $consultadedepartamentosResponse/WSSTATELISTType[1]/gWSSTATELISTDetailType/mWSSTATELISTDetailType
                    return
                        <ns1:consultaDepartamentosResponseRecordType>
                            {
                                for $ID in $mWSSTATELISTDetailType/ID
                                return
                                    <DEPT_CODE>{ fn:tokenize( $ID, "\.")[2] }</DEPT_CODE>
                            }
                            {
                                for $DESCRIPTION in $mWSSTATELISTDetailType/DESCRIPTION
                                return
                                    <DEPT_NAME>{ data($DESCRIPTION) }</DEPT_NAME>
                            }
                            {
                                for $COUNTRY in $mWSSTATELISTDetailType/COUNTRY
                                return
                                    <COUNTRY_CODE>{ data($COUNTRY) }</COUNTRY_CODE>
                            }
                        </ns1:consultaDepartamentosResponseRecordType>
                }
            </ns1:consultaDepartamentosResponseType>
        </ns1:consultaDepartamentosResponse>
};

declare variable $consultadedepartamentosResponse as element(ns0:ConsultadedepartamentosResponse) external;

xf:consultaDepartamentosOut($consultadedepartamentosResponse)