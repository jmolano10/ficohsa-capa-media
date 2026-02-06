xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns1:OutputParameters" location="../../../BusinessServices/consultarRemFRemXPagador/xsd/consultarRemFRemXPagador_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/registraRelConsPagoRem/xsd/ingresoRelConsPagoRem_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ingresoRelConsPagoRem";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultarRemFRemXPagador";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaRemesas/xq/ingresoRelConsPagFRem/";

declare function xf:ingresoRelConsPagFRem($outputParameters1 as element(ns1:OutputParameters))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            {
                let $result :=
                    for $PV_CLAVE_ITEM in $outputParameters1/ns1:PV_CODREMESADORA/ns1:PV_CLAVE_ITEM
                    return
                        <ns0:PV_CODIGOCONTRATO>{ data($PV_CLAVE_ITEM) }</ns0:PV_CODIGOCONTRATO>
                return
                    $result[1]
            }
            {
                let $result :=
                    for $PV_CLAVE_ITEM in $outputParameters1/ns1:PV_CLAVE/ns1:PV_CLAVE_ITEM
                    return
                        <ns0:PV_CLAVEREMESA>{ data($PV_CLAVE_ITEM) }</ns0:PV_CLAVEREMESA>
                return
                    $result[1]
            }
            {
                let $result :=
                    for $PV_CLAVE_ITEM in $outputParameters1/ns1:PV_MONEDA/ns1:PV_CLAVE_ITEM
                    return
                        <ns0:PV_MONEDA>{ data($PV_CLAVE_ITEM) }</ns0:PV_MONEDA>
                return
                    $result[1]
            }
            {
                let $result :=
                    for $PV_CLAVE_ITEM in $outputParameters1/ns1:PV_FECHAREMESA/ns1:PV_CLAVE_ITEM
                    return
                        <ns0:PD_FECHAREMESA>{ data($PV_CLAVE_ITEM) }</ns0:PD_FECHAREMESA>
                return
                    $result[1]
            }
            {
                let $result :=
                    for $PN_TASACAMBIO_ITEM in $outputParameters1/ns1:PN_VALOR/ns1:PN_TASACAMBIO_ITEM
                    return
                        <ns0:PN_MONTO>{ data($PN_TASACAMBIO_ITEM) }</ns0:PN_MONTO>
                return
                    $result[1]
            }
            {
                let $result :=
                    for $PN_TASACAMBIO_ITEM in $outputParameters1/ns1:PN_TASACAMBIO/ns1:PN_TASACAMBIO_ITEM
                    return
                        <ns0:PN_TASACAMBIO>{ data($PN_TASACAMBIO_ITEM) }</ns0:PN_TASACAMBIO>
                return
                    $result[1]
            }
            {
                let $result :=
                    for $PV_CLAVE_ITEM in $outputParameters1/ns1:PV_REMITENTE/ns1:PV_CLAVE_ITEM
                    return
                        <ns0:PV_REMITENTE>{ data($PV_CLAVE_ITEM) }</ns0:PV_REMITENTE>
                return
                    $result[1]
            }
            {
                let $result :=
                    for $PV_CLAVE_ITEM in $outputParameters1/ns1:PV_BENEFICIARIO/ns1:PV_CLAVE_ITEM
                    return
                        <ns0:PV_BENEFICIARIO>{ data($PV_CLAVE_ITEM) }</ns0:PV_BENEFICIARIO>
                return
                    $result[1]
            }          
            {
                let $result :=
                    for $PV_PAISORIGEN in $outputParameters1/ns1:PV_PAISORIGEN
                    return
                        <ns0:PV_PAISORIGEN>{ data($PV_PAISORIGEN) }</ns0:PV_PAISORIGEN>
                return
                    $result[1]
            }
            
        </ns0:InputParameters>
};

declare variable $outputParameters1 as element(ns1:OutputParameters) external;

xf:ingresoRelConsPagFRem($outputParameters1)