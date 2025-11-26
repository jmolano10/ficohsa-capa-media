xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$pagodeTarjetaCreditoResponse" element="ns0:PagodeTarjetaCreditoResponse" location="../../xsds/TransaccionesAutobancos/XMLSchema_1271081668.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Consultadeusuariosdelsistema" location="../../xsds/Core/XMLSchema_1632682327.xsd" ::)

declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/PagoTarjetaCredito/ConsultaDeUsuariosDelSistemaIn/";
declare namespace ns0 = "T24WebServicesImpl";

declare function xf:ConsultaDeUsuariosDelSistemaIn($userName as xs:string, $password as xs:string, $pagodeTarjetaCreditoResponse as element(ns0:PagodeTarjetaCreditoResponse))
    as element(ns0:Consultadeusuariosdelsistema) {
          <ns0:Consultadeusuariosdelsistema>
            <WebRequestCommon>
                <userName>{ $userName }</userName>
                <password>{ $password }</password>
            </WebRequestCommon>
            <WSUSERType>
                <enquiryInputCollection>
                <columnName>@ID</columnName>
                    {
                        let $result :=
                            for $INPUTTER in $pagodeTarjetaCreditoResponse/TELLERFINANCIALSERVICESType/gINPUTTER/INPUTTER
                            return
                                <criteriaValue>{ fn:tokenize(data($INPUTTER), "_")[2] }</criteriaValue>
                        return
                            $result[1]
                    }
                    <operand>EQ</operand>
                </enquiryInputCollection>
            </WSUSERType>
        </ns0:Consultadeusuariosdelsistema>
};

declare variable $userName as xs:string external;
declare variable $password as xs:string external;
declare variable $pagodeTarjetaCreditoResponse as element(ns0:PagodeTarjetaCreditoResponse) external;

xf:ConsultaDeUsuariosDelSistemaIn($userName, $password, $pagodeTarjetaCreditoResponse)
