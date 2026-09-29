xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://xmlns.oracle.com/pcbpel/adapter/db/sp/ConsultaCatalogosCobis";
(:: import schema at "../Schemas/ConsultaCatalogosCobis_sp.xsd" ::)
declare namespace ns2="https://www.ficohsa.com/nicaragua/referenceData";
(:: import schema at "../Schemas/GetCatalogsCoreBankingTypes.xsd" ::)

declare variable $responseCobis as element() (:: schema-element(ns1:OutputParameters) ::) external;

declare function local:func($responseCobis as element() (:: schema-element(ns1:OutputParameters) ::)) as element() (:: schema-element(ns2:getCatalogsCoreBankingResponse) ::) {
    <ns2:getCatalogsCoreBankingResponse>
        {
            for $row in $responseCobis/ns1:RowSet/ns1:Row
            return 
            <Catalogs>
                <Catalog>{fn:data($row/ns1:Column[@name='Catalogo'])}</Catalog>
                <Code>{fn:data($row/ns1:Column[@name='Codigo'])}</Code>
                <CodeIso>{fn:data($row/ns1:Column[@name='Codigo_iso'])}</CodeIso>
                <Description1>{fn:data($row/ns1:Column[@name='Descripcion_1'])}</Description1>
                <Description2>{fn:data($row/ns1:Column[@name='Descripcion_2'])}</Description2>
                <Status>{fn:data($row/ns1:Column[@name='Estado'])}</Status>
                <RegisterDate>{fn:data($row/ns1:Column[@name='Fecha_registro'])}</RegisterDate>
                <Action>{fn:data($row/ns1:Column[@name='Accion'])}</Action>
            </Catalogs>
        }
    </ns2:getCatalogsCoreBankingResponse>
};

local:func($responseCobis)