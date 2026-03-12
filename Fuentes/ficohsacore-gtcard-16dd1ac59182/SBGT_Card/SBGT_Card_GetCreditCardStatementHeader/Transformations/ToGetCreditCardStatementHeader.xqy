xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://tempuri.org/";
(:: import schema at "../Schemas/bfemEECCHistorico.xsd" ::)
declare namespace ns2="https://www.ficohsa.com/regional/card";
(:: import schema at "../Schemas/GetCreditCardStatementHeader.xsd" ::)

declare namespace bf. = "http://schemas.datacontract.org/2004/07/BF.Tarjetas.bfemEstadosCuentas.DataContracts";

declare variable $Output as element() (:: schema-element(ns1:ObtenerEncabezadosV2Response) ::) external;

declare function local:funcToGetCreditCardStatementHeader($Output as element() (:: schema-element(ns1:ObtenerEncabezadosV2Response) ::)) as element() (:: schema-element(ns2:getCreditCardStatementHeaderResponse) ::) {
    <ns2:getCreditCardStatementHeaderResponse>
        <StatusInfo>
            <Status></Status>
            <TransactionId></TransactionId>
            <ValueDate></ValueDate>
            <DateTime></DateTime>
            <GlobalId></GlobalId>
        </StatusInfo>
        {
            for $DatoObtenerEncabezadosV2 in $Output/ns1:ObtenerEncabezadosV2Result/bf.:Encabezados/bf.:DatoObtenerEncabezadosV2
            return 
            <CardDetails>
                <Balance>{fn:data($DatoObtenerEncabezadosV2/bf.:Balance)}</Balance>
                <Cycle>{fn:data($DatoObtenerEncabezadosV2/bf.:Ciclo)}</Cycle>
                <Currency>{fn:data($DatoObtenerEncabezadosV2/bf.:CodMoneda)}</Currency>
                <CycleDue>{fn:data($DatoObtenerEncabezadosV2/bf.:CycleDue)}</CycleDue>
                <CutoffDate>{fn:data($DatoObtenerEncabezadosV2/bf.:FechaCorte)}</CutoffDate>
                <FileLink>{fn:data($DatoObtenerEncabezadosV2/bf.:FileLink)}</FileLink>
                <MilesEarned>{fn:data($DatoObtenerEncabezadosV2/bf.:MilesEarned)}</MilesEarned>
                <AccountNumber>{fn:data($DatoObtenerEncabezadosV2/bf.:NumCuenta)}</AccountNumber>
                <Org>{fn:data($DatoObtenerEncabezadosV2/bf.:Org)}</Org>
                <MinPayment>{fn:data($DatoObtenerEncabezadosV2/bf.:PagoMinimo)}</MinPayment>
                <TotalPayment>{fn:data($DatoObtenerEncabezadosV2/bf.:PagoTotal)}</TotalPayment>
                <Period>{fn:data($DatoObtenerEncabezadosV2/bf.:Periodo)}</Period>
                <PointEarned>{fn:data($DatoObtenerEncabezadosV2/bf.:PointEarned)}</PointEarned>
                <OverdueAmount>{fn:data($DatoObtenerEncabezadosV2/bf.:SaldoMora)}</OverdueAmount>
                <TypeOrg>{fn:data($DatoObtenerEncabezadosV2/bf.:TipoOrg)}</TypeOrg></CardDetails>
        }
       

    </ns2:getCreditCardStatementHeaderResponse>
};

local:funcToGetCreditCardStatementHeader($Output)