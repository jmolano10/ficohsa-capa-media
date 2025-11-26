(:: pragma bea:global-element-parameter parameter="$consultadecoloniaobarrioResponse" element="ns0:ConsultadecoloniaobarrioResponse" location="../../../../Business_Resources/direcciones/Resources/XMLSchema_1123420404.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaBarrioColoniaResponse" location="../../../../Business_Resources/direcciones/ConsultaBarrioColonia/consultaBarrioColoniaTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaBarrioColoniaTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaBarrioColonia/xq/consultaBarrioColoniaOut/";

declare function xf:consultaBarrioColoniaOut($consultadecoloniaobarrioResponse as element(ns0:ConsultadecoloniaobarrioResponse))
    as element(ns1:consultaBarrioColoniaResponse) {
        let $WSNEIGHBORHOODLISTType := $consultadecoloniaobarrioResponse/WSNEIGHBORHOODLISTType[1]
        return
            <ns1:consultaBarrioColoniaResponse>
                {
                    for $gWSNEIGHBORHOODLISTDetailType in $WSNEIGHBORHOODLISTType/gWSNEIGHBORHOODLISTDetailType
                    return
                        <ns1:consultaBarrioColoniaResponseType>
                            {
                                for $mWSNEIGHBORHOODLISTDetailType in $gWSNEIGHBORHOODLISTDetailType/mWSNEIGHBORHOODLISTDetailType
                                return
                                    <ns1:consultaBarrioColoniaResponseRecordType>
                                        {
                                            for $ID in $mWSNEIGHBORHOODLISTDetailType/ID
                                            return
                                                <DISTRICT_CODE>{ data($ID) }</DISTRICT_CODE>
                                        }
                                        {
                                            for $DESCRIPTION in $mWSNEIGHBORHOODLISTDetailType/DESCRIPTION
                                            return
                                                <DISTRICT_NAME>{ data($DESCRIPTION) }</DISTRICT_NAME>
                                        }
                                        {
                                            for $CITY in $mWSNEIGHBORHOODLISTDetailType/CITY
                                            return
                                                <CITY_CODE>{ data($CITY) }</CITY_CODE>
                                        }
                                        {
                                            for $STATE in $mWSNEIGHBORHOODLISTDetailType/STATE
                                            return
                                                <DEPT_CODE>{ data($STATE) }</DEPT_CODE>
                                        }
                                        {
                                            for $COUNTRY in $mWSNEIGHBORHOODLISTDetailType/COUNTRY
                                            return
                                                <COUNTRY_CODE>{ data($COUNTRY) }</COUNTRY_CODE>
                                        }
                                    </ns1:consultaBarrioColoniaResponseRecordType>
                            }
                        </ns1:consultaBarrioColoniaResponseType>
                }
            </ns1:consultaBarrioColoniaResponse>
};

declare variable $consultadecoloniaobarrioResponse as element(ns0:ConsultadecoloniaobarrioResponse) external;

xf:consultaBarrioColoniaOut($consultadecoloniaobarrioResponse)