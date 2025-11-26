(:: pragma bea:global-element-parameter parameter="$creaUsuarioSistemaResponseIN" element="ns0:creaUsuarioSistemaResponse" location="../../AperturaProductos/xsd/aperturaProductosTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:creaUsuarioSistemaResponse" location="../xsd/creaUsuarioSistemaTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/creaUsuarioSistemaTypes";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/aperturaProductosTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CreacionUsuarioSistema/xq/creaUsuarioSistemaOUT/";

declare function xf:creaUsuarioSistemaOUT($creaUsuarioSistemaResponseIN as element(ns0:creaUsuarioSistemaResponse))
    as element(ns1:creaUsuarioSistemaResponse) {
        <ns1:creaUsuarioSistemaResponse>
            {
                for $USER_NAME in $creaUsuarioSistemaResponseIN/USER_NAME
                return
                    <ns1:USER_NAME>{ data($USER_NAME) }</ns1:USER_NAME>
            }
        </ns1:creaUsuarioSistemaResponse>
};

declare variable $creaUsuarioSistemaResponseIN as element(ns0:creaUsuarioSistemaResponse) external;

xf:creaUsuarioSistemaOUT($creaUsuarioSistemaResponseIN)
