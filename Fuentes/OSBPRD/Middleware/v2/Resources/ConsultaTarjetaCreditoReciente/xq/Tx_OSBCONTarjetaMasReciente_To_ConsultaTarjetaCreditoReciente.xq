(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns1:OutputParameters" location="../../../BusinessServices/ConsultaTarjetaCreditoReciente/xsd/OSBCONTarjetaMasReciente_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ConsultaTarjetaCreditoRecienteResponse" location="../xsd/ConsultaTarjetaCreditoRecienteTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/ConsultaTarjetaCreditoRecientexsd";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/OSBCONTarjetaMasReciente";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaTarjetaCreditoReciente/xq/Tx_OSBCONTarjetaMasReciente_To_ConsultaTarjetaCreditoReciente/";

declare function xf:Tx_OSBCONTarjetaMasReciente_To_ConsultaTarjetaCreditoReciente($outputParameters1 as element(ns1:OutputParameters))
    as element(ns0:ConsultaTarjetaCreditoRecienteResponse) {
        <ns0:ConsultaTarjetaCreditoRecienteResponse>
            <NumTarjeta>{ fn:replace(data($outputParameters1/ns1:RowSet[1]/ns1:Row[1]/ns1:Column[@name='NumTarjeta']),'^0*', '' ) }</NumTarjeta>
            <NombreCuenta>{ data($outputParameters1/ns1:RowSet[1]/ns1:Row[1]/ns1:Column[@name='NombreCuenta']) }</NombreCuenta>
            <Org>{ data($outputParameters1/ns1:RowSet[1]/ns1:Row[1]/ns1:Column[@name='Org']) }</Org>
            <Logo>{ data($outputParameters1/ns1:RowSet[1]/ns1:Row[1]/ns1:Column[@name='Logo']) }</Logo>
            <FechaExpiracion>{ data($outputParameters1/ns1:RowSet[1]/ns1:Row[1]/ns1:Column[@name='FechaExpiracion']) }</FechaExpiracion>
            <MensajeError>{ data($outputParameters1/ns1:MensajeError) }</MensajeError>
            <ERROR_SEVERITY>{ data($outputParameters1/ns1:RowSet[1]/ns1:Row[1]/ns1:Column[@name='ERROR_SEVERITY']) }</ERROR_SEVERITY>
            <ERROR_STATE>{ data($outputParameters1/ns1:RowSet[1]/ns1:Row[1]/ns1:Column[@name='ERROR_STATE']) }</ERROR_STATE>
            <CodigoError>{ data($outputParameters1/ns1:CodigoError) }</CodigoError>
        </ns0:ConsultaTarjetaCreditoRecienteResponse>
};

declare variable $outputParameters1 as element(ns1:OutputParameters) external;

xf:Tx_OSBCONTarjetaMasReciente_To_ConsultaTarjetaCreditoReciente($outputParameters1)