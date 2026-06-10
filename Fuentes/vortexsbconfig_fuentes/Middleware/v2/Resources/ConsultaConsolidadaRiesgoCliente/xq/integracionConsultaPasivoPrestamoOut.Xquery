<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns5="http://www.ficohsa.com.hn/middleware.services/consultaConsolidadaRiesgoClienteTypes";
(:: import schema at "../xsd/consultaConsolidadaRiesgoClienteTypes.xsd" ::)
declare namespace ns1="http://xmlns.oracle.com/pcbpel/adapter/db/sp/integracionConsultaPasivo";
(:: import schema at "../../../BusinessServices/DWConsultaConsolidada/integracionConsultaPasivo/xsd/integracionConsultaPasivo_sp.xsd" ::)
declare namespace ns3="http://xmlns.oracle.com/pcbpel/adapter/db/sp/integracionConsultaPrestamos";
(:: import schema at "../../../BusinessServices/DWConsultaConsolidada/integracionConsultaPrestamos/xsd/integracionConsultaPrestamos_sp.xsd" ::)
declare namespace ns2="http://xmlns.oracle.com/pcbpel/adapter/db/sp/integracionConsultaTrxPasivos";
(:: import schema at "../../../BusinessServices/DWConsultaConsolidada/integracionConsultaTrxPasivos/xsd/integracionConsultaTrxPasivos_sp.xsd" ::)
declare namespace ns4="http://xmlns.oracle.com/pcbpel/adapter/db/sp/integracionConsultaTrxPrestamos";
(:: import schema at "../../../BusinessServices/DWConsultaConsolidada/integracionConsultaTrxPrestamos/xsd/integracionConsultaTrxPrestamos_sp.xsd" ::)

declare variable $responseConsultaPasivo as element() (:: schema-element(ns1:OutputParameters) ::) external;
declare variable $ResponseConsultaTrxPasivos as element() (:: schema-element(ns2:OutputParameters) ::) external;
declare variable $ResponseConsultaPrestamos as element() (:: schema-element(ns3:OutputParameters) ::) external;
declare variable $ResponseConsultaTrxPrestamos as element() (:: schema-element(ns4:OutputParameters) ::) external;

declare function local:func($responseConsultaPasivo as element() (:: schema-element(ns1:OutputParameters) ::), 
                            $ResponseConsultaTrxPasivos as element() (:: schema-element(ns2:OutputParameters) ::), 
                            $ResponseConsultaPrestamos as element() (:: schema-element(ns3:OutputParameters) ::), 
                            $ResponseConsultaTrxPrestamos as element() (:: schema-element(ns4:OutputParameters) ::)) 
                            as element() (:: schema-element(ns5:consultaConsolidadaRiesgoClienteResponse) ::) {
    &lt;ns5:consultaConsolidadaRiesgoClienteResponse/>
};

local:func($responseConsultaPasivo, $ResponseConsultaTrxPasivos, $ResponseConsultaPrestamos, $ResponseConsultaTrxPrestamos)</con:xquery>
    <con:dependencies>
        <con:importSchema location="../xsd/consultaConsolidadaRiesgoClienteTypes.xsd">
            <con:schema ref="Middleware/v2/Resources/ConsultaConsolidadaRiesgoCliente/xsd/consultaConsolidadaRiesgoClienteTypes"/>
        </con:importSchema>
        <con:importSchema location="../../../BusinessServices/DWConsultaConsolidada/integracionConsultaPasivo/xsd/integracionConsultaPasivo_sp.xsd">
            <con:schema ref="Middleware/v2/BusinessServices/DWConsultaConsolidada/integracionConsultaPasivo/xsd/integracionConsultaPasivo_sp"/>
        </con:importSchema>
        <con:importSchema location="../../../BusinessServices/DWConsultaConsolidada/integracionConsultaPrestamos/xsd/integracionConsultaPrestamos_sp.xsd">
            <con:schema ref="Middleware/v2/BusinessServices/DWConsultaConsolidada/integracionConsultaPrestamos/xsd/integracionConsultaPrestamos_sp"/>
        </con:importSchema>
        <con:importSchema location="../../../BusinessServices/DWConsultaConsolidada/integracionConsultaTrxPasivos/xsd/integracionConsultaTrxPasivos_sp.xsd">
            <con:schema ref="Middleware/v2/BusinessServices/DWConsultaConsolidada/integracionConsultaTrxPasivos/xsd/integracionConsultaTrxPasivos_sp"/>
        </con:importSchema>
        <con:importSchema location="../../../BusinessServices/DWConsultaConsolidada/integracionConsultaTrxPrestamos/xsd/integracionConsultaTrxPrestamos_sp.xsd">
            <con:schema ref="Middleware/v2/BusinessServices/DWConsultaConsolidada/integracionConsultaTrxPrestamos/xsd/integracionConsultaTrxPrestamos_sp"/>
        </con:importSchema>
    </con:dependencies>
</con:xqueryEntry>