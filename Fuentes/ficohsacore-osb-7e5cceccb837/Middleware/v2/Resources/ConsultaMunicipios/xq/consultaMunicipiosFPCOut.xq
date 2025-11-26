(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns1:OutputParameters" location="../../../BusinessServices/FPC/listadoMunicipios/xsd/listadoMunicipiosFPC_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaMunicipiosResponse" location="../../../../Business_Resources/direcciones/ConsultaMunicipios/consultaMunicipiosTypes.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/listadoMunicipiosFPC";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaMunicipiosTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaMunicipios/xq/consultaMunicipiosFPCOut/";

declare function xf:consultaMunicipiosFPCOut($outputParameters as element(ns1:OutputParameters),
    $countryCode as xs:string,
    $deptCode as xs:string)
    as element(ns0:consultaMunicipiosResponse) {
        <ns0:consultaMunicipiosResponse>
            <ns0:consultaMunicipiosResponseType>
                {
                    for $PT_CANTONES_ITEM in $outputParameters/ns1:PT_CANTONES/ns1:PT_CANTONES_ITEM
                    return
                        <ns0:consultaMunicipiosResponseRecordType>
                            {
                                for $COD_CANTON in $PT_CANTONES_ITEM/ns1:COD_CANTON
                                return
                                    <CITY_CODE>{ data($COD_CANTON) }</CITY_CODE>
                            }
                            {
                                for $DES_CANTON in $PT_CANTONES_ITEM/ns1:DES_CANTON
                                return
                                    <CITY_NAME>{ data($DES_CANTON) }</CITY_NAME>
                            }
                            <DEPT_CODE>{ $deptCode }</DEPT_CODE>
                            <COUNTRY_CODE>{ $countryCode }</COUNTRY_CODE>
                        </ns0:consultaMunicipiosResponseRecordType>
                }
            </ns0:consultaMunicipiosResponseType>
        </ns0:consultaMunicipiosResponse>
};

declare variable $outputParameters as element(ns1:OutputParameters) external;
declare variable $countryCode as xs:string external;
declare variable $deptCode as xs:string external;

xf:consultaMunicipiosFPCOut($outputParameters,
    $countryCode,
    $deptCode)