(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns0:OutputParameters" location="../../../BusinessServices/ConsultarRemLocalId/xsd/consultarRemLocalId_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/registraRelConsPagoRem/xsd/ingresoRelConsPagoRem_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultarRemLocalId";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ingresoRelConsPagoRem";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaRemesas/xq/ingresoRelConsPagoRem/";

declare function xf:ingresoRelConsPagoRem($outputParameters1 as element(ns0:OutputParameters))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            {
                let $result :=
                    for $PV_CLAVE_ITEM in $outputParameters1/ns0:PV_CODREMESADORA/ns0:PV_CLAVE_ITEM
                    return
                        <ns1:PV_CODIGOCONTRATO>{ data($PV_CLAVE_ITEM) }</ns1:PV_CODIGOCONTRATO>
                return
                    $result[1]
            }
            {
                let $result :=
                    for $PV_CLAVE_ITEM in $outputParameters1/ns0:PV_CLAVE/ns0:PV_CLAVE_ITEM
                    return
                        <ns1:PV_CLAVEREMESA>{ data($PV_CLAVE_ITEM) }</ns1:PV_CLAVEREMESA>
                return
                    $result[1]
            }
            {
                let $result :=
                    for $PV_CLAVE_ITEM in $outputParameters1/ns0:PV_MONEDA/ns0:PV_CLAVE_ITEM
                    return
                        <ns1:PV_MONEDA>{ data($PV_CLAVE_ITEM) }</ns1:PV_MONEDA>
                return
                    $result[1]
            }
            {
                let $result :=
                    for $PV_CLAVE_ITEM in $outputParameters1/ns0:PV_FECHAREMESA/ns0:PV_CLAVE_ITEM
                    return
                        <ns1:PD_FECHAREMESA>{ data($PV_CLAVE_ITEM) }</ns1:PD_FECHAREMESA>
                return
                    $result[1]
            }
            {
                let $result :=
                    for $PN_TASACAMBIO_ITEM in $outputParameters1/ns0:PN_VALOR/ns0:PN_TASACAMBIO_ITEM
                    return
                        <ns1:PN_MONTO>{ data($PN_TASACAMBIO_ITEM) }</ns1:PN_MONTO>
                return
                    $result[1]
            }
            {
                let $result :=
                    for $PN_TASACAMBIO_ITEM in $outputParameters1/ns0:PN_TASACAMBIO/ns0:PN_TASACAMBIO_ITEM
                    return
                        <ns1:PN_TASACAMBIO>{ data($PN_TASACAMBIO_ITEM) }</ns1:PN_TASACAMBIO>
                return
                    $result[1]
            }
            {
                let $result :=
                    for $PV_CLAVE_ITEM in $outputParameters1/ns0:PV_REMITENTE/ns0:PV_CLAVE_ITEM
                    return
                        <ns1:PV_REMITENTE>{ data($PV_CLAVE_ITEM) }</ns1:PV_REMITENTE>
                return
                    $result[1]
            }
            {
                let $result :=
                    for $PV_CLAVE_ITEM in $outputParameters1/ns0:PV_BENEFICIARIO/ns0:PV_CLAVE_ITEM
                    return
                        <ns1:PV_BENEFICIARIO>{ data($PV_CLAVE_ITEM) }</ns1:PV_BENEFICIARIO>
                return
                    $result[1]
            }

            {
                let $result :=
                    for $PV_PAISORIGEN in $outputParameters1/ns0:PV_PAISORIGEN
                    return
                        <ns1:PV_PAISORIGEN>{ data($PV_PAISORIGEN) }</ns1:PV_PAISORIGEN>
                return
                    $result[1]
            }
        </ns1:InputParameters>
};

declare variable $outputParameters1 as element(ns0:OutputParameters) external;

xf:ingresoRelConsPagoRem($outputParameters1)