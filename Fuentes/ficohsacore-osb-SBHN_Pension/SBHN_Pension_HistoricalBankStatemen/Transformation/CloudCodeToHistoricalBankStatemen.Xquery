<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="https://www.ficohsa.com/honduras/pension";
(:: import schema at "../Schemas/HistoricalBankStatemenTypes.xsd" ::)
declare namespace ns1="https://www.ficohsa.com/honduras/pension/cloudCodeTypes";
(:: import schema at "../../SBHN_Pension_Commons/Schemas/CloudCodeTypes.xsd" ::)

declare variable $cloudCodeResponse as element() (:: schema-element(ns1:estadoCuentasHistoricosResponse) ::) external;
declare variable $globalId as xs:string external;
declare variable $status as xs:string external;

declare function local:func($cloudCodeResponse as element() (:: schema-element(ns1:estadoCuentasHistoricosResponse) ::),
$globalId as xs:string, 
$status as xs:string) as element() (:: schema-element(ns2:historicalBankStatementResponse) ::) {
    <ns2:historicalBankStatementResponse>
        <StatusInfo>
            <Status>{fn:data($status)}</Status>
            <TransactionId></TransactionId>
            <ValueDate></ValueDate>
            <DateTime></DateTime>
            <GlobalId>{fn:data($globalId)}</GlobalId>
        </StatusInfo>
        {
         for $item in $cloudCodeResponse/ns1:datos
         return
        <Data>
            <Message>{fn:data($cloudCodeResponse/ns1:mensaje)}</Message>
            <Data>
            {
             for $statusAccount in $item/ns1:estadoCuenta
             return
                <StatusAccount>
                        <Date>{fn:data($statusAccount/ns1:fecha)}</Date>
                        <NameClient>{fn:data($statusAccount/ns1:nombreCliente)}</NameClient>
                        <EmailClient>{fn:data($statusAccount/ns1:emailCliente)}</EmailClient>
                        <CustomerNumber>{fn:data($statusAccount/ns1:numeroCliente)}</CustomerNumber>
                        {
                        for $movements in $statusAccount/ns1:movimientos
                        return
                    <Movements>                        
                           <Currency>{fn:data($movements/ns1:moneda)}</Currency>
                           <Account>{fn:data($movements/ns1:cuenta)}</Account>
                           <Yield>{fn:data($movements/ns1:rendimiento)}</Yield>
                           <TotalStaff>{fn:data($movements/ns1:totalPersonal)}</TotalStaff>
                           <TotalEmployee>{fn:data($movements/ns1:totalPatronal)}</TotalEmployee>
                           <GrandTotal>{fn:data($movements/ns1:granTotal)}</GrandTotal>
                           {
                           for $transacctions in $movements/ns1:transacciones
                           return
                        <Transactions>
                                <Date>{fn:data($transacctions/ns1:fecha)}</Date>
                                <TypeMovement>{fn:data($transacctions/ns1:tipoMovimiento)}</TypeMovement>
                                <DescriptionTransaction>{fn:data($transacctions/ns1:descripcionTransaccion)}</DescriptionTransaction>
                                <MovementStaff>{fn:data($transacctions/ns1:movimientoPersonal)}</MovementStaff>
                                <EmployerMovement>{fn:data($transacctions/ns1:movimientoPatronal)}</EmployerMovement>
                                <TotalMovement>{fn:data($transacctions/ns1:movimientoTotal)}</TotalMovement>
                        </Transactions>
                        }
                    </Movements>
                    }
                </StatusAccount>
                }
            </Data>
        </Data>
        }
    </ns2:historicalBankStatementResponse>
};

local:func($cloudCodeResponse,$globalId, $status )]]></con:xquery>
    <con:dependencies>
        <con:importSchema location="../Schemas/HistoricalBankStatemenTypes.xsd">
            <con:schema ref="SBHN_Pension_HistoricalBankStatemen/Schemas/HistoricalBankStatemenTypes"/>
        </con:importSchema>
        <con:importSchema location="../../SBHN_Pension_Commons/Schemas/CloudCodeTypes.xsd">
            <con:schema ref="SBHN_Pension_Commons/Schemas/CloudCodeTypes"/>
        </con:importSchema>
    </con:dependencies>
</con:xqueryEntry>