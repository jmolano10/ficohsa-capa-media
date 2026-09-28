xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns1:OutputParameters" location="../../../BusinessServices/ProcesosPA/obtenerBlazeData/xsd/obtenerBlazeData_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaExtrafinanciamientoDisponibleResponse" location="../xsd/consultaExtrafinanciamientoDisponibleTypes.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaExtrafinanciamientoDisponible/xq/consultaExtrafinanciamientoDisponiblePAOut/";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/obtenerBlazeData";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaExtrafinanciamientoDisponibleTypes";

declare function xf:consultaExtrafinanciamientoDisponiblePAOut($outputParameters as element(ns1:OutputParameters))
    as element(ns0:consultaExtrafinanciamientoDisponibleResponse) {
        <ns0:consultaExtrafinanciamientoDisponibleResponse>
    {
        for $row in $outputParameters/ns1:RowSet/ns1:Row
        return
        (
            for $noCliente in $row/ns1:Column[upper-case(@name) = 'NOCLIENTE']
            return
                <CUSTOMER_ID>{  data($noCliente)}</CUSTOMER_ID>,
            for $cuenta in $row/ns1:Column[upper-case(@name) = 'CUENTA']
            return
                <ACCOUNT_NUMBER>{ data($cuenta) }</ACCOUNT_NUMBER>,
            for $montoExtra in $row/ns1:Column[upper-case(@name) = 'MONTO_OFERTA']
            return
                <AVAILABLE_AMOUNT>{ data($montoExtra) }</AVAILABLE_AMOUNT>,
            for $cuotaxf in $row/ns1:Column[upper-case(@name) = 'CUOTAOFERTA']
            return
                <FEE_AMOUNT>{ data($cuotaxf) }</FEE_AMOUNT>,
            for $tasaExtra in $row/ns1:Column[upper-case(@name) = 'TASA_OFERTA']
            return
                <INTEREST_RATE>{ data($tasaExtra) }</INTEREST_RATE>,
            for $fechaVigencia in $row/ns1:Column[upper-case(@name) = 'FECHA_VIGENCIA']
            return
                <DUE_DATE>{ data($fechaVigencia) }</DUE_DATE>,
            for $estadoOfertaExtra in $row/ns1:Column[upper-case(@name) = 'ESTADOOFERTA']
            return
                <AVAILABLE>{ data($estadoOfertaExtra) }</AVAILABLE>,
            for $monto_12_PT in $row/ns1:Column[upper-case(@name) = 'MONTO_12_OFERTA']
            return 
                (
                <TERMBREAKDOWN_INFORMATION>
                        <AMOUNT>{ data($monto_12_PT) }</AMOUNT>
                        <TERM>12</TERM>
                </TERMBREAKDOWN_INFORMATION>
                ),
            for $monto_18_PT in $row/ns1:Column[upper-case(@name) = 'MONTO_18_OFERTA']
            return
                (
                <TERMBREAKDOWN_INFORMATION>
                        <AMOUNT>{ data($monto_18_PT) }</AMOUNT>
                        <TERM>18</TERM>
                </TERMBREAKDOWN_INFORMATION>
                ),
            for $monto_24_PT in $row/ns1:Column[upper-case(@name) = 'MONTO_24_OFERTA']
            return 
                (
                <TERMBREAKDOWN_INFORMATION>
                        <AMOUNT>{ data($monto_24_PT) }</AMOUNT>
                        <TERM>24</TERM>
                </TERMBREAKDOWN_INFORMATION>
                ),
            for $monto_36_PT in $row/ns1:Column[upper-case(@name) = 'MONTO_36_OFERTA']
            return
                ( 
                <TERMBREAKDOWN_INFORMATION>
                        <AMOUNT>{ data($monto_36_PT) }</AMOUNT>
                        <TERM>36</TERM>
                </TERMBREAKDOWN_INFORMATION>
                ),
            for $monto_48_PT in $row/ns1:Column[upper-case(@name) = 'MONTO_48_OFERTA']
            return 
                (
                <TERMBREAKDOWN_INFORMATION>
                        <AMOUNT>{ data($monto_48_PT) }</AMOUNT>
                        <TERM>48</TERM>
                </TERMBREAKDOWN_INFORMATION>
                ),
            for $monto_60_PT in $row/ns1:Column[upper-case(@name) = 'MONTO_60_OFERTA']
            return
                ( 
                <TERMBREAKDOWN_INFORMATION>
                        <AMOUNT>{ data($monto_60_PT) }</AMOUNT>
                        <TERM>60</TERM>
                </TERMBREAKDOWN_INFORMATION>
                ),
                for $identificacion in $row/ns1:Column[upper-case(@name) = 'IDENTIFICACION']
            return
                <NUMBER_ID>{  data($identificacion)}</NUMBER_ID>,
                for $name in $row/ns1:Column[upper-case(@name) = 'NOMBRECLIENTE']
            return
                <CUSTOMER_NAME>{  data($name)}</CUSTOMER_NAME>,
                for $tipoOferta in $row/ns1:Column[upper-case(@name) = 'TIPOOFERTA']
            return
                <OFFER_TYPE>{  data($tipoOferta)}</OFFER_TYPE>
        )
    }
    </ns0:consultaExtrafinanciamientoDisponibleResponse>
};

declare variable $outputParameters as element(ns1:OutputParameters) external;

xf:consultaExtrafinanciamientoDisponiblePAOut($outputParameters)