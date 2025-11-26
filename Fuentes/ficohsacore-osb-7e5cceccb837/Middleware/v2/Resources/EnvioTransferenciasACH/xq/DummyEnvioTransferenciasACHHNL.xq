(:: pragma bea:global-element-parameter parameter="$envioTransferenciasACH" element="ns2:envioTransferenciasACH" location="../xsd/envioTransferenciasACHTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:SendDebitHNLResponse" location="../../../BusinessServices/PYST/envioTransfACH/xsd/XMLSchema_-1986733638.xsd" ::)

declare namespace ns0 = "http://schemas.datacontract.org/2004/07/WcfACHOnline";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/envioTransferenciasACHTypes";
declare namespace ns1 = "http://tempuri.org/";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/EnvioTransferenciasACH/xq/DummyEnvioTransferenciasACHHNL/";

declare function xf:DummyEnvioTransferenciasACHHNL($envioTransferenciasACH as element(ns2:envioTransferenciasACH))
    as element(ns1:SendDebitHNLResponse) {
    
    if (fn:contains(data($envioTransferenciasACH/ORIGINATOR/ACCOUNT),'199990000000001')) then (
        <ns1:SendDebitHNLResponse>
            <ns1:SendDebitHNLResult>
                <ns0:Message>Fondos Insuficientes</ns0:Message>
                <ns0:MessageID>01001990ABC1234567890ABCDEF00000R01</ns0:MessageID>
                <ns0:ReasonCode>R01</ns0:ReasonCode>
                <ns0:SuccessIndicator>ERROR</ns0:SuccessIndicator>
            </ns1:SendDebitHNLResult>
        </ns1:SendDebitHNLResponse>
        ) 
     elseif (fn:contains(data($envioTransferenciasACH/ORIGINATOR/ACCOUNT),'199990000000002')) then (
        <ns1:SendDebitHNLResponse>
            <ns1:SendDebitHNLResult>
                <ns0:Message>Cuenta Cerrada</ns0:Message>
                <ns0:MessageID>01001990ABC1234567890ABCDEF00000R02</ns0:MessageID>
                <ns0:ReasonCode>R02</ns0:ReasonCode>
                <ns0:SuccessIndicator>ERROR</ns0:SuccessIndicator>
            </ns1:SendDebitHNLResult>
        </ns1:SendDebitHNLResponse>
        ) 
     elseif (fn:contains(data($envioTransferenciasACH/ORIGINATOR/ACCOUNT),'199990000000003')) then (
        <ns1:SendDebitHNLResponse>
            <ns1:SendDebitHNLResult>
                <ns0:Message>Numero de Cuenta Inexistente</ns0:Message>
                <ns0:MessageID>01001990ABC1234567890ABCDEF00000R03</ns0:MessageID>
                <ns0:ReasonCode>R03</ns0:ReasonCode>
                <ns0:SuccessIndicator>ERROR</ns0:SuccessIndicator>
            </ns1:SendDebitHNLResult>
        </ns1:SendDebitHNLResponse> 
        ) 
     elseif (fn:contains(data($envioTransferenciasACH/ORIGINATOR/ACCOUNT),'199990000000004')) then (
        <ns1:SendDebitHNLResponse>
            <ns1:SendDebitHNLResult>
                <ns0:Message>Número de Cuenta Inválido</ns0:Message>
                <ns0:MessageID>01001990ABC1234567890ABCDEF00000R04</ns0:MessageID>
                <ns0:ReasonCode>R04</ns0:ReasonCode>
                <ns0:SuccessIndicator>ERROR</ns0:SuccessIndicator>
            </ns1:SendDebitHNLResult>
        </ns1:SendDebitHNLResponse> 
        ) 
     elseif (fn:contains(data($envioTransferenciasACH/ORIGINATOR/ACCOUNT),'199990000000007')) then (
        <ns1:SendDebitHNLResponse>
            <ns1:SendDebitHNLResult>
                <ns0:Message>Autorización Revocada por el Destinatario</ns0:Message>
                <ns0:MessageID>01001990ABC1234567890ABCDEF00000R07</ns0:MessageID>
                <ns0:ReasonCode>R07</ns0:ReasonCode>
                <ns0:SuccessIndicator>ERROR</ns0:SuccessIndicator>
            </ns1:SendDebitHNLResult>
        </ns1:SendDebitHNLResponse> 
        ) 
     elseif (fn:contains(data($envioTransferenciasACH/ORIGINATOR/ACCOUNT),'199990000000008')) then (
        <ns1:SendDebitHNLResponse>
            <ns1:SendDebitHNLResult>
                <ns0:Message>Suspensión de Pago</ns0:Message>
                <ns0:MessageID>01001990ABC1234567890ABCDEF00000R08</ns0:MessageID>
                <ns0:ReasonCode>R08</ns0:ReasonCode>
                <ns0:SuccessIndicator>ERROR</ns0:SuccessIndicator>
            </ns1:SendDebitHNLResult>
        </ns1:SendDebitHNLResponse> 
        ) 
     elseif (fn:contains(data($envioTransferenciasACH/ORIGINATOR/ACCOUNT),'199990000000009')) then (
        <ns1:SendDebitHNLResponse>
            <ns1:SendDebitHNLResult>
                <ns0:Message>Fondos no Disponibles</ns0:Message>
                <ns0:MessageID>01001990ABC1234567890ABCDEF00000R09</ns0:MessageID>
                <ns0:ReasonCode>R09</ns0:ReasonCode>
                <ns0:SuccessIndicator>ERROR</ns0:SuccessIndicator>
            </ns1:SendDebitHNLResult>
        </ns1:SendDebitHNLResponse> 
        )
     elseif (fn:contains(data($envioTransferenciasACH/ORIGINATOR/ACCOUNT),'199990000000010')) then (
        <ns1:SendDebitHNLResponse>
            <ns1:SendDebitHNLResult>
                <ns0:Message>No Existe Autorización del Destinatario</ns0:Message>
                <ns0:MessageID>01001990ABC1234567890ABCDEF00000R10</ns0:MessageID>
                <ns0:ReasonCode>R10</ns0:ReasonCode>
                <ns0:SuccessIndicator>ERROR</ns0:SuccessIndicator>
            </ns1:SendDebitHNLResult>
        </ns1:SendDebitHNLResponse> 
        )
     elseif (fn:contains(data($envioTransferenciasACH/ORIGINATOR/ACCOUNT),'199990000000011')) then (
        <ns1:SendDebitHNLResponse>
            <ns1:SendDebitHNLResult>
                <ns0:Message>La transacción de Débito Excede el Monto Autorizado</ns0:Message>
                <ns0:MessageID>01001990ABC1234567890ABCDEF00000R11</ns0:MessageID>
                <ns0:ReasonCode>R11</ns0:ReasonCode>
                <ns0:SuccessIndicator>ERROR</ns0:SuccessIndicator>
            </ns1:SendDebitHNLResult>
        </ns1:SendDebitHNLResponse> 
        )
     elseif (fn:contains(data($envioTransferenciasACH/ORIGINATOR/ACCOUNT),'199990000000016')) then (
        <ns1:SendDebitHNLResponse>
            <ns1:SendDebitHNLResult>
                <ns0:Message>Cuenta Bloqueada o Inactiva</ns0:Message>
                <ns0:MessageID>01001990ABC1234567890ABCDEF00000R16</ns0:MessageID>
                <ns0:ReasonCode>R16</ns0:ReasonCode>
                <ns0:SuccessIndicator>ERROR</ns0:SuccessIndicator>
            </ns1:SendDebitHNLResult>
        </ns1:SendDebitHNLResponse> 
        )
     elseif (fn:contains(data($envioTransferenciasACH/ORIGINATOR/ACCOUNT),'199990000000017')) then (
        <ns1:SendDebitHNLResponse>
            <ns1:SendDebitHNLResult>
                <ns0:Message>Monto Inválido de Transacción</ns0:Message>
                <ns0:MessageID>01001990ABC1234567890ABCDEF00000R17</ns0:MessageID>
                <ns0:ReasonCode>R17</ns0:ReasonCode>
                <ns0:SuccessIndicator>ERROR</ns0:SuccessIndicator>
            </ns1:SendDebitHNLResult>
        </ns1:SendDebitHNLResponse> 
        )
     elseif (fn:contains(data($envioTransferenciasACH/ORIGINATOR/ACCOUNT),'199990000000020')) then (
        <ns1:SendDebitHNLResponse>
            <ns1:SendDebitHNLResult>
                <ns0:Message>Registro de Adenda Inválida</ns0:Message>
                <ns0:MessageID>01001990ABC1234567890ABCDEF00000R20</ns0:MessageID>
                <ns0:ReasonCode>R20</ns0:ReasonCode>
                <ns0:SuccessIndicator>ERROR</ns0:SuccessIndicator>
            </ns1:SendDebitHNLResult>
        </ns1:SendDebitHNLResponse> 
        )
     elseif (fn:contains(data($envioTransferenciasACH/ORIGINATOR/ACCOUNT),'199990000000022')) then (
        <ns1:SendDebitHNLResponse>
            <ns1:SendDebitHNLResult>
                <ns0:Message>Identificación de Ordenante Inválido</ns0:Message>
                <ns0:MessageID>01001990ABC1234567890ABCDEF00000R22</ns0:MessageID>
                <ns0:ReasonCode>R22</ns0:ReasonCode>
                <ns0:SuccessIndicator>ERROR</ns0:SuccessIndicator>
            </ns1:SendDebitHNLResult>
        </ns1:SendDebitHNLResponse> 
        )
     elseif (fn:contains(data($envioTransferenciasACH/ORIGINATOR/ACCOUNT),'199990000000024')) then (
        <ns1:SendDebitHNLResponse>
            <ns1:SendDebitHNLResult>
                <ns0:Message>Entrada Duplicada</ns0:Message>
                <ns0:MessageID>01001990ABC1234567890ABCDEF00000R24</ns0:MessageID>
                <ns0:ReasonCode>R24</ns0:ReasonCode>
                <ns0:SuccessIndicator>ERROR</ns0:SuccessIndicator>
            </ns1:SendDebitHNLResult>
        </ns1:SendDebitHNLResponse> 
        )
     elseif (fn:contains(data($envioTransferenciasACH/ORIGINATOR/ACCOUNT),'199990000000029')) then (
        <ns1:SendDebitHNLResponse>
            <ns1:SendDebitHNLResult>
                <ns0:Message>La fecha de la Transacción de Débito ha Expirado</ns0:Message>
                <ns0:MessageID>01001990ABC1234567890ABCDEF00000R29</ns0:MessageID>
                <ns0:ReasonCode>R29</ns0:ReasonCode>
                <ns0:SuccessIndicator>ERROR</ns0:SuccessIndicator>
            </ns1:SendDebitHNLResult>
        </ns1:SendDebitHNLResponse> 
        )
     elseif (fn:contains(data($envioTransferenciasACH/ORIGINATOR/ACCOUNT),'199990000000031')) then (
        <ns1:SendDebitHNLResponse>
            <ns1:SendDebitHNLResult>
                <ns0:Message>Rechazos Especiales</ns0:Message>
                <ns0:MessageID>01001990ABC1234567890ABCDEF00000R31</ns0:MessageID>
                <ns0:ReasonCode>R31</ns0:ReasonCode>
                <ns0:SuccessIndicator>ERROR</ns0:SuccessIndicator>
            </ns1:SendDebitHNLResult>
        </ns1:SendDebitHNLResponse> 
        )
     elseif (fn:contains(data($envioTransferenciasACH/ORIGINATOR/ACCOUNT),'199990000001001')) then (
        <ns1:SendDebitHNLResponse>
            <ns1:SendDebitHNLResult>
                <ns0:Message>Error Inesperado</ns0:Message>
                <ns0:MessageID>01001990ABC1234567890ABCDEF00001001</ns0:MessageID>
                <ns0:ReasonCode>1001</ns0:ReasonCode>
                <ns0:SuccessIndicator>ERROR</ns0:SuccessIndicator>
            </ns1:SendDebitHNLResult>
        </ns1:SendDebitHNLResponse> 
        )
     elseif (fn:contains(data($envioTransferenciasACH/ORIGINATOR/ACCOUNT),'199990000001002')) then (
        <ns1:SendDebitHNLResponse>
            <ns1:SendDebitHNLResult>
                <ns0:Message>La IFO no está Autenticada</ns0:Message>
                <ns0:MessageID>01001990ABC1234567890ABCDEF00001002</ns0:MessageID>
                <ns0:ReasonCode>1002</ns0:ReasonCode>
                <ns0:SuccessIndicator>ERROR</ns0:SuccessIndicator>
            </ns1:SendDebitHNLResult>
        </ns1:SendDebitHNLResponse> 
        )
     elseif (fn:contains(data($envioTransferenciasACH/ORIGINATOR/ACCOUNT),'199990000001003')) then (
        <ns1:SendDebitHNLResponse>
            <ns1:SendDebitHNLResult>
                <ns0:Message>La IFR no Existe</ns0:Message>
                <ns0:MessageID>01001990ABC1234567890ABCDEF00001003</ns0:MessageID>
                <ns0:ReasonCode>1003</ns0:ReasonCode>
                <ns0:SuccessIndicator>ERROR</ns0:SuccessIndicator>
            </ns1:SendDebitHNLResult>
        </ns1:SendDebitHNLResponse> 
        )
     elseif (fn:contains(data($envioTransferenciasACH/ORIGINATOR/ACCOUNT),'199990000001004')) then (
        <ns1:SendDebitHNLResponse>
            <ns1:SendDebitHNLResult>
                <ns0:Message>Identificación de Mensaje Duplicado</ns0:Message>
                <ns0:MessageID>01001990ABC1234567890ABCDEF00001004</ns0:MessageID>
                <ns0:ReasonCode>1004</ns0:ReasonCode>
                <ns0:SuccessIndicator>ERROR</ns0:SuccessIndicator>
            </ns1:SendDebitHNLResult>
        </ns1:SendDebitHNLResponse> 
        )
     elseif (fn:contains(data($envioTransferenciasACH/ORIGINATOR/ACCOUNT),'199990000001006')) then (
        <ns1:SendDebitHNLResponse>
            <ns1:SendDebitHNLResult>
                <ns0:Message>Código de Moneda en el Encabezado del Mensaje Inválido</ns0:Message>
                <ns0:MessageID>01001990ABC1234567890ABCDEF00001006</ns0:MessageID>
                <ns0:ReasonCode>1006</ns0:ReasonCode>
                <ns0:SuccessIndicator>ERROR</ns0:SuccessIndicator>
            </ns1:SendDebitHNLResult>
        </ns1:SendDebitHNLResponse> 
        )
     else(
	        <ns1:SendDebitHNLResponse>
	            <ns1:SendDebitHNLResult>
	                <ns0:Message>TRANSACCION PROCESADA EXITOSAMENTE</ns0:Message>
	                <ns0:MessageID>01001990ABC1234567890ABCDEF000000OK</ns0:MessageID>
	                <ns0:ReasonCode></ns0:ReasonCode>
	                <ns0:SuccessIndicator>SUCCESS</ns0:SuccessIndicator>
	            </ns1:SendDebitHNLResult>
	        </ns1:SendDebitHNLResponse>
        )
        
};

declare variable $envioTransferenciasACH as element(ns2:envioTransferenciasACH) external;

xf:DummyEnvioTransferenciasACHHNL($envioTransferenciasACH)