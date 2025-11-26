(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns1:OutputParameters" location="../../../BusinessServices/MasterData/obtenerBlazeData/xsd/obtenerBlazeData_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaExtrafinanciamientoDisponibleResponse" location="../xsd/consultaExtrafinanciamientoDisponibleTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaExtrafinanciamientoDisponibleTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/obtenerBlazeData";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaExtrafinanciamientoDisponible/xq/consultaExtrafinanciamientoDisponibleOut/";

declare function xf:consultaExtrafinanciamientoDisponibleOut($outputParameters as element(ns1:OutputParameters))
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
            for $montoExtra in $row/ns1:Column[upper-case(@name) = 'MONTO_EXTRA']
            return
                <AVAILABLE_AMOUNT>{ data($montoExtra) }</AVAILABLE_AMOUNT>,
            for $cuotaxf in $row/ns1:Column[upper-case(@name) = 'CUOTAXF']
            return
                <FEE_AMOUNT>{ data($cuotaxf) }</FEE_AMOUNT>,
            for $tasaExtra in $row/ns1:Column[upper-case(@name) = 'TASA_EXTRA']
            return
                <INTEREST_RATE>{ data($tasaExtra) }</INTEREST_RATE>,
            for $fechaVigencia in $row/ns1:Column[upper-case(@name) = 'FECHA_VIGENCIA']
            return
                <DUE_DATE>{ data($fechaVigencia) }</DUE_DATE>,
            for $estadoOfertaExtra in $row/ns1:Column[upper-case(@name) = 'ESTADOOFERTAEXTRA']
            return
                <AVAILABLE>{ data($estadoOfertaExtra) }</AVAILABLE>,
            for $monto_12_PT in $row/ns1:Column[upper-case(@name) = 'MONTO_12_PT']
            return 
                (
                <TERMBREAKDOWN_INFORMATION>
                        <AMOUNT>{ data($monto_12_PT) }</AMOUNT>
                        <TERM>12</TERM>
                </TERMBREAKDOWN_INFORMATION>
                ),
            for $monto_18_PT in $row/ns1:Column[upper-case(@name) = 'MONTO_18_PT']
            return
                (
                <TERMBREAKDOWN_INFORMATION>
                        <AMOUNT>{ data($monto_18_PT) }</AMOUNT>
                        <TERM>18</TERM>
                </TERMBREAKDOWN_INFORMATION>
                ),
            for $monto_24_PT in $row/ns1:Column[upper-case(@name) = 'MONTO_24_PT']
            return 
                (
                <TERMBREAKDOWN_INFORMATION>
                        <AMOUNT>{ data($monto_24_PT) }</AMOUNT>
                        <TERM>24</TERM>
                </TERMBREAKDOWN_INFORMATION>
                ),
            for $monto_36_PT in $row/ns1:Column[upper-case(@name) = 'MONTO_36_PT']
            return
                ( 
                <TERMBREAKDOWN_INFORMATION>
                        <AMOUNT>{ data($monto_36_PT) }</AMOUNT>
                        <TERM>36</TERM>
                </TERMBREAKDOWN_INFORMATION>
                ),
            for $monto_48_PT in $row/ns1:Column[upper-case(@name) = 'MONTO_48_PT']
            return 
                (
                <TERMBREAKDOWN_INFORMATION>
                        <AMOUNT>{ data($monto_48_PT) }</AMOUNT>
                        <TERM>48</TERM>
                </TERMBREAKDOWN_INFORMATION>
                ),
            for $monto_60_PT in $row/ns1:Column[upper-case(@name) = 'MONTO_60_PT']
            return
                ( 
                <TERMBREAKDOWN_INFORMATION>
                        <AMOUNT>{ data($monto_60_PT) }</AMOUNT>
                        <TERM>60</TERM>
                </TERMBREAKDOWN_INFORMATION>
                )
        )
    }
    </ns0:consultaExtrafinanciamientoDisponibleResponse>
};

declare variable $outputParameters as element(ns1:OutputParameters) external;

xf:consultaExtrafinanciamientoDisponibleOut($outputParameters)