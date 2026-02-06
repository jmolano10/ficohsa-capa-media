xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns0:OutputParameters" location="../../../BusinessServices/FPC/listadoPaises/xsd/listadoPaisesFPC_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaPaisesResponse" location="../../../../Business_Resources/direcciones/consultaPaises/consultaPaisesTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaPaisesTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/listadoPaisesFPC";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaPaises/xq/consultaPaisesFPCOut/";

declare function xf:consultaPaisesFPCOut($outputParameters as element(ns0:OutputParameters))
    as element(ns1:consultaPaisesResponse) {
        <ns1:consultaPaisesResponse>
            <ns1:consultaPaisesResponseType>
                {
                    for $PT_PAISES_ITEM in $outputParameters/ns0:PT_PAISES/ns0:PT_PAISES_ITEM
                    return
                        <ns1:consultaPaisesResponseRecordType>
                            {
                                for $COD_PAIS in $PT_PAISES_ITEM/ns0:COD_PAIS
                                return
                                    <COUNTRY_CODE>{ data($COD_PAIS) }</COUNTRY_CODE>
                            }
                            {
                                for $DES_PAIS in $PT_PAISES_ITEM/ns0:DES_PAIS
                                return
                                    <COUNTRY_NAME>{ data($DES_PAIS) }</COUNTRY_NAME>
                            }
                        </ns1:consultaPaisesResponseRecordType>
                }
            </ns1:consultaPaisesResponseType>
        </ns1:consultaPaisesResponse>
};

declare variable $outputParameters as element(ns0:OutputParameters) external;

xf:consultaPaisesFPCOut($outputParameters)