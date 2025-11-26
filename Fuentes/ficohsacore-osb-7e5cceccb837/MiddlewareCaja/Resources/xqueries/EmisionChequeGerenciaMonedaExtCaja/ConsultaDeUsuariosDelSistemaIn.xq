(:: pragma bea:global-element-parameter parameter="$emisiondechequedegerenciaFCY" element="ns0:EmisiondechequedegerenciaFCY" location="../../xsds/EmisionChequeGerenciaMonedaExtCaja/EmisionChequeGerenciaMonedaExtCaja.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Consultadeusuariosdelsistema" location="../../xsds/Core/XMLSchema_1632682327.xsd" ::)

declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/EmisionChequeGerenciaMonedaExtCaja/ConsultaDeUsuariosDelSistemaIn/";

declare function xf:ConsultaDeUsuariosDelSistemaIn($emisiondechequedegerenciaFCY as element(ns0:EmisiondechequedegerenciaFCY))
    as element(ns0:Consultadeusuariosdelsistema) {
        <ns0:Consultadeusuariosdelsistema>
            {
                for $WebRequestCommon in $emisiondechequedegerenciaFCY/WebRequestCommon
                return
                    <WebRequestCommon>{ $WebRequestCommon/@* , $WebRequestCommon/node() }</WebRequestCommon>
            }
            <WSUSERType>
                <enquiryInputCollection>
                    <columnName>SIGN.ON.NAME</columnName>
                    <criteriaValue>{ data($emisiondechequedegerenciaFCY/WebRequestCommon/userName) }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
            </WSUSERType>
        </ns0:Consultadeusuariosdelsistema>
};

declare variable $emisiondechequedegerenciaFCY as element(ns0:EmisiondechequedegerenciaFCY) external;

xf:ConsultaDeUsuariosDelSistemaIn($emisiondechequedegerenciaFCY)