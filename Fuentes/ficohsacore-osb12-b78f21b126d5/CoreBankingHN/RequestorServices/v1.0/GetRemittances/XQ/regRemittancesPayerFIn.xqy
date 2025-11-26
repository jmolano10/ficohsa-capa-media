xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://xmlns.oracle.com/pcbpel/adapter/db/sp/getRemittancesLocalId";
(:: import schema at "../../../../ProviderServices/XSD/GetRemittancesLocalId/getRemittancesLocalId_sp.xsd" ::)
declare namespace ns2="http://xmlns.oracle.com/pcbpel/adapter/db/sp/regRemittancesPayer";
(:: import schema at "../../../../ProviderServices/XSD/RegRemittancesPayer/regRemittancesPayer_sp.xsd" ::)

declare variable $getRemittancesLocalIdResponse as element() (:: schema-element(ns1:OutputParameters) ::) external;

declare function local:func($getRemittancesLocalIdResponse as element() (:: schema-element(ns1:OutputParameters) ::)) as element() (:: schema-element(ns2:InputParameters) ::) {
    <ns2:InputParameters>
        {
                let $result :=
                    for $PV_CLAVE_ITEM in $getRemittancesLocalIdResponse/ns1:PV_CODREMESADORA/ns1:PV_CLAVE_ITEM
                    return
                        <ns1:PV_CODIGOCONTRATO>{ data($PV_CLAVE_ITEM) }</ns1:PV_CODIGOCONTRATO>
                return
                    $result[1]
            }
            {
                let $result :=
                    for $PV_CLAVE_ITEM in $getRemittancesLocalIdResponse/ns1:PV_CLAVE/ns1:PV_CLAVE_ITEM
                    return
                        <ns1:PV_CLAVEREMESA>{ data($PV_CLAVE_ITEM) }</ns1:PV_CLAVEREMESA>
                return
                    $result[1]
            }
            {
                let $result :=
                    for $PV_CLAVE_ITEM in $getRemittancesLocalIdResponse/ns1:PV_MONEDA/ns1:PV_CLAVE_ITEM
                    return
                        <ns1:PV_MONEDA>{ data($PV_CLAVE_ITEM) }</ns1:PV_MONEDA>
                return
                    $result[1]
            }
            {
                let $result :=
                    for $PV_CLAVE_ITEM in $getRemittancesLocalIdResponse/ns1:PV_FECHAREMESA/ns1:PV_CLAVE_ITEM
                    return
                        <ns1:PD_FECHAREMESA>{ data($PV_CLAVE_ITEM) }</ns1:PD_FECHAREMESA>
                return
                    $result[1]
            }
            {
                let $result :=
                    for $PN_TASACAMBIO_ITEM in $getRemittancesLocalIdResponse/ns1:PN_VALOR/ns1:PN_TASACAMBIO_ITEM
                    return
                        <ns1:PN_MONTO>{ data($PN_TASACAMBIO_ITEM) }</ns1:PN_MONTO>
                return
                    $result[1]
            }
            {
                let $result :=
                    for $PN_TASACAMBIO_ITEM in $getRemittancesLocalIdResponse/ns1:PN_TASACAMBIO/ns1:PN_TASACAMBIO_ITEM
                    return
                        <ns1:PN_TASACAMBIO>{ data($PN_TASACAMBIO_ITEM) }</ns1:PN_TASACAMBIO>
                return
                    $result[1]
            }
            {
                let $result :=
                    for $PV_CLAVE_ITEM in $getRemittancesLocalIdResponse/ns1:PV_REMITENTE/ns1:PV_CLAVE_ITEM
                    return
                        <ns1:PV_REMITENTE>{ data($PV_CLAVE_ITEM) }</ns1:PV_REMITENTE>
                return
                    $result[1]
            }
            {
                let $result :=
                    for $PV_CLAVE_ITEM in $getRemittancesLocalIdResponse/ns1:PV_BENEFICIARIO/ns1:PV_CLAVE_ITEM
                    return
                        <ns1:PV_BENEFICIARIO>{ data($PV_CLAVE_ITEM) }</ns1:PV_BENEFICIARIO>
                return
                    $result[1]
            }

            {
                let $result :=
                    for $PV_PAISORIGEN in $getRemittancesLocalIdResponse/ns1:PV_PAISORIGEN
                    return
                        <ns1:PV_PAISORIGEN>{ data($PV_PAISORIGEN) }</ns1:PV_PAISORIGEN>
                return
                    $result[1]
            }
    </ns2:InputParameters>
};

local:func($getRemittancesLocalIdResponse)
