(:: pragma bea:global-element-parameter parameter="$consultadeprofesionesResponse" element="ns1:ConsultadeprofesionesResponse" location="../Resources/XMLSchema_123738754.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaProfesionesResponse" location="consultaProfesionesTypes.xsd" ::)

declare namespace ns1 = "T24WebServicesImpl";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaProfesionesTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/consultaProfesion/ConsultaProfesiones/consultaProfesionesOut/";

declare function xf:consultaProfesionesOut($consultadeprofesionesResponse as element(ns1:ConsultadeprofesionesResponse))
    as element(ns0:consultaProfesionesResponse) {
        <ns0:consultaProfesionesResponse>
            <ns0:consultaProfesionesResponseType>
                {
                    for $mWSPROFESSIONLISTDetailType in $consultadeprofesionesResponse/WSPROFESSIONLISTType[1]/gWSPROFESSIONLISTDetailType/mWSPROFESSIONLISTDetailType
                    return
                        <ns0:consultaProfesionesResponseRecordType>
                            {
                                for $ID in $mWSPROFESSIONLISTDetailType/ID
                                return
                                    <PROFESSION_ID>{ data($ID) }</PROFESSION_ID>
                            }
                            {
                                for $DESCRIPTION in $mWSPROFESSIONLISTDetailType/DESCRIPTION
                                return
                                    <PROFESSION>{ data($DESCRIPTION) }</PROFESSION>
                            }
                        </ns0:consultaProfesionesResponseRecordType>
                }
            </ns0:consultaProfesionesResponseType>
        </ns0:consultaProfesionesResponse>
};

declare variable $consultadeprofesionesResponse as element(ns1:ConsultadeprofesionesResponse) external;

xf:consultaProfesionesOut($consultadeprofesionesResponse)