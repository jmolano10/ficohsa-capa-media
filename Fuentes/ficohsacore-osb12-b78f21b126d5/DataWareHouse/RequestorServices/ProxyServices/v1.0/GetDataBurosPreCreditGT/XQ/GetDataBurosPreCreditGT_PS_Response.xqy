xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://tempuri.org/";
(:: import schema at "../../../../../ProviderServices/WSDL/GetDataBurosPreCredit/v1.0/precalificacion.wsdl" ::)
declare namespace ns2="http://www.ficohsa.com.hn/middleware.services/GetDataBurosPreCreditGT_BS";
(:: import schema at "../../../../../ProviderServices/XSD/GetDataBurosPreCredit/v1.0/GetDataBurosPreCreditGT_BS.xsd" ::)

declare variable $ConsultaBurosResponse as element() (:: schema-element(ns1:ConsultaBurosResponse) ::) external;

declare function local:GetDataBurosPreCreditGT_PS_Request($ConsultaBurosResponse as element() (:: schema-element(ns1:ConsultaBurosResponse) ::)) as element() (:: schema-element(ns2:getDataBurosPreCreditGTResponse) ::) {
        <ns2:getDataBurosPreCreditGTResponse>
            {
                for $CODIGO_PROSPECTO in $ConsultaBurosResponse/ns1:MSGPRE/ns1:HEADER/ns1:CODIGO_PROSPECTO
                return
                <ns2:CODIGO_PROSPECTO>{fn:data($CODIGO_PROSPECTO)}</ns2:CODIGO_PROSPECTO>
            }
            {
                for $CODIGO_EMPRESA in $ConsultaBurosResponse/ns1:MSGPRE/ns1:HEADER/ns1:CODIGO_EMPRESA
                return
                <ns2:CODIGO_EMPRESA>{fn:data($CODIGO_EMPRESA)}</ns2:CODIGO_EMPRESA>
            }
            {
                for $RELACION_PROSPECTO in $ConsultaBurosResponse/ns1:MSGPRE/ns1:HEADER/ns1:RELACION_PROSPECTO
                return
                <ns2:RELACION_PROSPECTO>{fn:data($RELACION_PROSPECTO)}</ns2:RELACION_PROSPECTO>
            }
            {
                for $TIPO_PERSONA in $ConsultaBurosResponse/ns1:MSGPRE/ns1:HEADER/ns1:TIPO_PERSONA
                return
                <ns2:TIPO_PERSONA>{fn:data($TIPO_PERSONA)}</ns2:TIPO_PERSONA>
            }
            {
                for $USUARIO in $ConsultaBurosResponse/ns1:MSGPRE/ns1:HEADER/ns1:USUARIO
                return
                <ns2:USUARIO>{fn:data($USUARIO)}</ns2:USUARIO>
            }
            {
                for $REFERENCIA in $ConsultaBurosResponse/ns1:MSGPRE/ns1:HEADER/ns1:REFERENCIA
                return
                <ns2:REFERENCIA>{fn:data($REFERENCIA)}</ns2:REFERENCIA>
            }
            {
                for $PC in $ConsultaBurosResponse/ns1:MSGPRE/ns1:HEADER/ns1:PC
                return
                <ns2:PC>{fn:data($PC)}</ns2:PC>
            }
            {
                for $IP in $ConsultaBurosResponse/ns1:MSGPRE/ns1:HEADER/ns1:IP
                return
                <ns2:IP>{fn:data($IP)}</ns2:IP>
            }
            {
                for $CODIGO in $ConsultaBurosResponse/ns1:MSGPRE/ns1:BODY/ns1:ESTADO_CONSULTA/ns1:CODIGO
                return
                <ns2:CODIGO>{fn:data($CODIGO)}</ns2:CODIGO>
            }
            {
                for $MENSAJE in $ConsultaBurosResponse/ns1:MSGPRE/ns1:BODY/ns1:ESTADO_CONSULTA/ns1:MENSAJE
                return
                <ns2:MENSAJE>{fn:data($MENSAJE)}</ns2:MENSAJE>
            }
            {
                if(fn:exists($ConsultaBurosResponse/ns1:MSGPRE/ns1:BODY/ns1:TRANSUNION/ns1:MODELOS_ANALISIS/ns1:MODELO)) then (
                    <ns2:MODELOS_ANALISIS>
                    {
                        for $MODELO in $ConsultaBurosResponse/ns1:MSGPRE/ns1:BODY/ns1:TRANSUNION/ns1:MODELOS_ANALISIS/ns1:MODELO
                        return(
                            <ns2:MODELO>
                            {
                                for $PRODUCTO in $MODELO/ns1:PRODUCTO
                                return
                                <ns2:PRODUCTO>{fn:data($PRODUCTO)}</ns2:PRODUCTO>
                            }
                            {
                                for $RESULTADO in $MODELO/ns1:RESULTADO
                                return
                                <ns2:RESULTADO>{fn:data($RESULTADO)}</ns2:RESULTADO>
                            }
                            {
                                for $RAZONES in $MODELO/ns1:RAZONES
                                return
                                <ns2:RAZONES>{fn:data($RAZONES)}</ns2:RAZONES>
                            }
                            </ns2:MODELO>
                        )
                    }
            </ns2:MODELOS_ANALISIS>
                ) else ()
            }
            <ns2:INFORMACION_CLIENTE>
                {
                    if(fn:exists($ConsultaBurosResponse/ns1:MSGPRE/ns1:BODY/ns1:TRANSUNION/ns1:INFORMACION_CLIENTE/ns1:DIRECCIONES/ns1:DIRECCION)) then (
                        <ns2:DIRECCIONES>
                        {
                            for $DIRECCION in $ConsultaBurosResponse/ns1:MSGPRE/ns1:BODY/ns1:TRANSUNION/ns1:INFORMACION_CLIENTE/ns1:DIRECCIONES/ns1:DIRECCION
                            return(
                                <ns2:DIRECCION>
                                {
                                    for $TIPO in $DIRECCION/ns1:TIPO
                                    return
                                    <ns2:TIPO>{fn:data($TIPO)}</ns2:TIPO>
                                }
                                {
                                    for $DESC in $DIRECCION/ns1:DESC
                                    return
                                    <ns2:DESC>{fn:data($DESC)}</ns2:DESC>
                                }
                            </ns2:DIRECCION>
                            )
                        }
                      </ns2:DIRECCIONES>
                    ) else ()
                }
                {
                    if(fn:exists($ConsultaBurosResponse/ns1:MSGPRE/ns1:BODY/ns1:TRANSUNION/ns1:INFORMACION_CLIENTE/ns1:TELEFONOS/ns1:TELEFONO)) then (
                        <ns2:TELEFONOS>
                        {
                            for $TELEFONO in $ConsultaBurosResponse/ns1:MSGPRE/ns1:BODY/ns1:TRANSUNION/ns1:INFORMACION_CLIENTE/ns1:TELEFONOS/ns1:TELEFONO
                            return(
                                <ns2:TELEFONO>
                                {
                                    for $TIPO in $TELEFONO/ns1:TIPO
                                    return
                                    <ns2:TIPO>{fn:data($TIPO)}</ns2:TIPO>
                                }
                                {
                                    for $TELEFONO in $TELEFONO/ns1:TELEFONO
                                    return
                                    <ns2:TELEFONO>{fn:data($TELEFONO)}</ns2:TELEFONO>
                                }
                                </ns2:TELEFONO>
                            )
                        }
                        </ns2:TELEFONOS>
                    ) else ()
                }
            </ns2:INFORMACION_CLIENTE>
            {
                if(fn:exists($ConsultaBurosResponse/ns1:MSGPRE/ns1:BODY/ns1:TRANSUNION/ns1:LISTA_CONSULTAS/ns1:CONSULTA)) then (
                    <ns2:LISTA_CONSULTAS>
                    {
                        for $CONSULTA in $ConsultaBurosResponse/ns1:MSGPRE/ns1:BODY/ns1:TRANSUNION/ns1:LISTA_CONSULTAS/ns1:CONSULTA
                        return(
                            <ns2:CONSULTA>
                            {
                                for $TIPO_CONSULTA in $CONSULTA/ns1:TIPO_CONSULTA
                                return
                                <ns2:TIPO_CONSULTA>{fn:data($TIPO_CONSULTA)}</ns2:TIPO_CONSULTA>
                            }
                            {
                                for $ENTIDAD_CONSULTANTE in $CONSULTA/ns1:ENTIDAD_CONSULTANTE
                                return
                                <ns2:ENTIDAD_CONSULTANTE>{fn:data($ENTIDAD_CONSULTANTE)}</ns2:ENTIDAD_CONSULTANTE>
                            }
                            {
                                for $FECHA_CONSULTA in $CONSULTA/ns1:FECHA_CONSULTA
                                return
                                <ns2:FECHA_CONSULTA>{fn:data($FECHA_CONSULTA)}</ns2:FECHA_CONSULTA>
                            }
                            {
                                for $MOTIVO in $CONSULTA/ns1:MOTIVO
                                return
                                <ns2:MOTIVO>{fn:data($MOTIVO)}</ns2:MOTIVO>
                            }
                          </ns2:CONSULTA>
                        )
                    }
                  </ns2:LISTA_CONSULTAS>
                ) else ()
            }
            {
                if(fn:exists($ConsultaBurosResponse/ns1:MSGPRE/ns1:BODY/ns1:TRANSUNION/ns1:COMPORTAMIENTO_OBLIGACIONES/ns1:OBLIGACION)) then (
                    <ns2:COMPORTAMIENTO_OBLIGACIONES>
                    {
                        for $OBLIGACION in $ConsultaBurosResponse/ns1:MSGPRE/ns1:BODY/ns1:TRANSUNION/ns1:COMPORTAMIENTO_OBLIGACIONES/ns1:OBLIGACION
                        return(
                            <ns2:OBLIGACION>
                            {
                                for $SECTOR_OBLIGACION in $OBLIGACION/@SECTOR
                                return
                                <ns2:SECTOR_OBLIGACION>{fn:data($SECTOR_OBLIGACION)}</ns2:SECTOR_OBLIGACION>
                            }
                            {
                                for $TIPO_OBLIGACION in $OBLIGACION/@TIPO
                                return
                                <ns2:TIPO_OBLIGACION>{fn:data($TIPO_OBLIGACION)}</ns2:TIPO_OBLIGACION>
                            }
                            {
                                for $ENTIDAD_INFORMANTE in $OBLIGACION/ns1:ENTIDAD_INFORMANTE
                                return
                                 <ns2:ENTIDAD_INFORMANTE>{fn:data($ENTIDAD_INFORMANTE)}</ns2:ENTIDAD_INFORMANTE>
                             }
                             {
                                 for $GARANTIA in $OBLIGACION/ns1:GARANTIA
                                 return
                                 <ns2:GARANTIA>{fn:data($GARANTIA)}</ns2:GARANTIA>
                             }
                             {
                                 for $PERIODO_PAGO in $OBLIGACION/ns1:PERIODO_PAGO
                                 return
                                 <ns2:PERIODO_PAGO>{fn:data($PERIODO_PAGO)}</ns2:PERIODO_PAGO>
                             }
                             {
                                  for $CALIFICACION in $OBLIGACION/ns1:COMPORTAMIENTO_PAGO/ns1:CALIFICACION
                                  return
                                  <ns2:CALIFICACION>{fn:data($CALIFICACION)}</ns2:CALIFICACION>
                             }
                             {
                                  for $ESTADO in $OBLIGACION/ns1:COMPORTAMIENTO_PAGO/ns1:ESTADO
                                  return
                                  <ns2:ESTADO>{fn:data($ESTADO)}</ns2:ESTADO>
                             }
                             {
                                  for $LIMITE in $OBLIGACION/ns1:COMPORTAMIENTO_PAGO/ns1:LIMITE
                                  return
                                  <ns2:LIMITE>{fn:data($LIMITE)}</ns2:LIMITE>
                             }
                             {
                                  for $TIPO in $OBLIGACION/ns1:TIPO
                                  return
                                  <ns2:TIPO>{fn:data($TIPO)}</ns2:TIPO>
                             }
                             {
                                  for $NUMERO in $OBLIGACION/ns1:NUMERO
                                  return
                                  <ns2:NUMERO>{fn:data($NUMERO)}</ns2:NUMERO>
                             }
                             {
                                  for $FECHA_APERTURA in $OBLIGACION/ns1:FECHA_APERTURA
                                  return
                                  <ns2:FECHA_APERTURA>{fn:data($FECHA_APERTURA)}</ns2:FECHA_APERTURA>
                             }
                             {
                                  for $FECHA_VENCIMIENTO in $OBLIGACION/ns1:FECHA_VENCIMIENTO
                                  return
                                  <ns2:FECHA_VENCIMIENTO>{fn:data($FECHA_VENCIMIENTO)}</ns2:FECHA_VENCIMIENTO>
                             }
                             {
                                  for $FECHA_ACTUALIZACION in $OBLIGACION/ns1:FECHA_ACTUALIZACION
                                  return
                                  <ns2:FECHA_ACTUALIZACION>{fn:data($FECHA_ACTUALIZACION)}</ns2:FECHA_ACTUALIZACION>
                             }
                             {
                                  for $MONEDA in $OBLIGACION/ns1:COMPORTAMIENTO_PAGO/ns1:MONEDA
                                  return
                                  <ns2:MONEDA>{fn:data($MONEDA)}</ns2:MONEDA>
                             }
                             {
                                  for $SALDO_ACTUAL in $OBLIGACION/ns1:COMPORTAMIENTO_PAGO/ns1:SALDO_ACTUAL
                                  return
                                  <ns2:SALDO_ACTUAL>{fn:data($SALDO_ACTUAL)}</ns2:SALDO_ACTUAL>
                             }
                             {
                                  for $SALDO_MORA in $OBLIGACION/ns1:COMPORTAMIENTO_PAGO/ns1:SALDO_MORA
                                  return
                                  <ns2:SALDO_MORA>{fn:data($SALDO_MORA)}</ns2:SALDO_MORA>
                             }
                             {
                                  for $CUOTA in $OBLIGACION/ns1:COMPORTAMIENTO_PAGO/ns1:CUOTA
                                  return
                                  <ns2:CUOTA>{fn:data($CUOTA)}</ns2:CUOTA>
                             }
                            <ns2:VECTOR_HISTORICO ANIO="{fn:data($OBLIGACION/ns1:COMPORTAMIENTO_PAGO/ns1:VECTOR_HISTORICO/@ANIO)}">
                            { 
                                for $ITEM in $OBLIGACION/ns1:COMPORTAMIENTO_PAGO/ns1:VECTOR_HISTORICO/ns1:ITEM
                                return(
                                    <ns2:ITEM ANIO="{fn:data($ITEM/@ANIO)}" MES="{fn:data($ITEM/@MES)}">{fn:data($ITEM)}</ns2:ITEM>
                                )
                            }
                            </ns2:VECTOR_HISTORICO>
                        </ns2:OBLIGACION>
                        )
                    }
                </ns2:COMPORTAMIENTO_OBLIGACIONES>
                ) else ()
            }
            <ns2:SIRC>
            {
                for $DEUDAS_VIGENTES in $ConsultaBurosResponse/ns1:MSGPRE/ns1:BODY/ns1:SIRC/ns1:DEUDAS_VIGENTES
                return(
                    <ns2:DEUDAS_VIGENTES>
                    {
                        for $NOM_VINCULO in $DEUDAS_VIGENTES/ns1:NOM_VINCULO
                        return
                        <ns2:NOM_VINCULO>{fn:data($NOM_VINCULO)}</ns2:NOM_VINCULO>
                    }
                    {
                        for $ENTIDAD in $DEUDAS_VIGENTES/ns1:ENTIDAD
                        return
                        <ns2:ENTIDAD>{fn:data($ENTIDAD)}</ns2:ENTIDAD>
                    }
                    {
                        for $DESC_TIPO_ACTIVO in $ConsultaBurosResponse/ns1:MSGPRE/ns1:BODY/ns1:SIRC/ns1:DEUDAS_VIGENTES/ns1:DESC_TIPO_ACTIVO
                        return
                        <ns2:DESC_TIPO_ACTIVO>{fn:data($DESC_TIPO_ACTIVO)}</ns2:DESC_TIPO_ACTIVO>
                    }
                        {
                            for $DESC_TIPO_GARANTIA in $DEUDAS_VIGENTES/ns1:DESC_TIPO_GARANTIA
                            return
                            <ns2:DESC_TIPO_GARANTIA>{fn:data($DESC_TIPO_GARANTIA)}</ns2:DESC_TIPO_GARANTIA>
                        }
                        {
                            for $MONEDA in $DEUDAS_VIGENTES/ns1:MONEDA
                            return
                            <ns2:MONEDA>{fn:data($MONEDA)}</ns2:MONEDA>
                        }
                        {
                            for $CAPITAL_ORIGINAL in $DEUDAS_VIGENTES/ns1:CAPITAL_ORIGINAL
                            return
                            <ns2:CAPITAL_ORIGINAL>{fn:data($CAPITAL_ORIGINAL)}</ns2:CAPITAL_ORIGINAL>
                        }
                        {
                            for $SALDO in $DEUDAS_VIGENTES/ns1:SALDO
                            return
                            <ns2:SALDO>{fn:data($SALDO)}</ns2:SALDO>
                        }
                        {
                            for $VENCIDO in $DEUDAS_VIGENTES/ns1:VENCIDO
                            return
                            <ns2:VENCIDO>{fn:data($VENCIDO)}</ns2:VENCIDO>
                        }
                        {
                            for $FECHA_ACTIVO in $DEUDAS_VIGENTES/ns1:FECHA_ACTIVO
                            return
                            <ns2:FECHA_ACTIVO>{fn:data($FECHA_ACTIVO)}</ns2:FECHA_ACTIVO>
                        }
                        {
                            for $FECHA_CONSESION in $DEUDAS_VIGENTES/ns1:FECHA_CONSESION
                            return
                            <ns2:FECHA_CONSESION>{fn:data($FECHA_CONSESION)}</ns2:FECHA_CONSESION>
                        }
                        {
                            for $FECHA_VENCIMIENTO in $DEUDAS_VIGENTES/ns1:FECHA_VENCIMIENTO
                            return
                            <ns2:FECHA_VENCIMIENTO>{fn:data($FECHA_VENCIMIENTO)}</ns2:FECHA_VENCIMIENTO>
                        }
                        {
                            for $FECHA_CANCELACION in $DEUDAS_VIGENTES/ns1:FECHA_CANCELACION
                            return
                            <ns2:FECHA_CANCELACION>{fn:data($FECHA_CANCELACION)}</ns2:FECHA_CANCELACION>
                        }
                        {
                            for $COMPORTAMIENTO in $DEUDAS_VIGENTES/ns1:COMPORTAMIENTO
                            return
                            <ns2:COMPORTAMIENTO>{fn:data($COMPORTAMIENTO)}</ns2:COMPORTAMIENTO>
                        }
                        {
                            for $CATEGORIA in $DEUDAS_VIGENTES/ns1:CATEGORIA
                            return
                            <ns2:CATEGORIA>{fn:data($CATEGORIA)}</ns2:CATEGORIA>
                        }
                </ns2:DEUDAS_VIGENTES>
                )
            }
            {
                for $DEUDAS_CANCELADAS in $ConsultaBurosResponse/ns1:MSGPRE/ns1:BODY/ns1:SIRC/ns1:DEUDAS_CANCELADAS
                return(
                    <ns2:DEUDAS_CANCELADAS>
                        {
                            for $TIPO_ACTIVO in $DEUDAS_CANCELADAS/ns1:TIPO_ACTIVO
                            return
                            <ns2:TIPO_ACTIVO>{fn:data($TIPO_ACTIVO)}</ns2:TIPO_ACTIVO>
                        }
                        {
                            for $TIPO_GARANTIA in $DEUDAS_CANCELADAS/ns1:TIPO_GARANTIA
                            return
                            <ns2:TIPO_GARANTIA>{fn:data($TIPO_GARANTIA)}</ns2:TIPO_GARANTIA>
                        }
                    {
                        for $ENTIDAD in $DEUDAS_CANCELADAS/ns1:ENTIDAD
                        return
                        <ns2:ENTIDAD>{fn:data($ENTIDAD)}</ns2:ENTIDAD>
                    }
                        {
                            for $MONEDA in $DEUDAS_CANCELADAS/ns1:MONEDA
                            return
                            <ns2:MONEDA>{fn:data($MONEDA)}</ns2:MONEDA>
                        }
                        {
                            for $CAPITAL_ORIGINAL in $DEUDAS_CANCELADAS/ns1:CAPITAL_ORIGINAL
                            return
                            <ns2:CAPITAL_ORIGINAL>{fn:data($CAPITAL_ORIGINAL)}</ns2:CAPITAL_ORIGINAL>
                        }
                        {
                            for $SALDO in $DEUDAS_CANCELADAS/ns1:SALDO
                            return
                            <ns2:SALDO>{fn:data($SALDO)}</ns2:SALDO>
                        }
                        {
                            for $VENCIDO in $DEUDAS_CANCELADAS/ns1:VENCIDO
                            return
                            <ns2:VENCIDO>{fn:data($VENCIDO)}</ns2:VENCIDO>
                        }
                        {
                            for $FECHA_ACTIVO in $DEUDAS_CANCELADAS/ns1:FECHA_ACTIVO
                            return
                            <ns2:FECHA_ACTIVO>{fn:data($FECHA_ACTIVO)}</ns2:FECHA_ACTIVO>
                        }
                        {
                            for $FECHA_CONSESION in $DEUDAS_CANCELADAS/ns1:FECHA_CONSESION
                            return
                            <ns2:FECHA_CONSESION>{fn:data($FECHA_CONSESION)}</ns2:FECHA_CONSESION>
                        }
                        {
                            for $FECHA_VENCIMIENTO in $DEUDAS_CANCELADAS/ns1:FECHA_VENCIMIENTO
                            return
                            <ns2:FECHA_VENCIMIENTO>{fn:data($FECHA_VENCIMIENTO)}</ns2:FECHA_VENCIMIENTO>
                        }
                        {
                            for $FECHA_CANCELACION in $DEUDAS_CANCELADAS/ns1:FECHA_CANCELACION
                            return
                            <ns2:FECHA_CANCELACION>{fn:data($FECHA_CANCELACION)}</ns2:FECHA_CANCELACION>
                        }
                        {
                            for $COMPORTAMIENTO in $DEUDAS_CANCELADAS/ns1:COMPORTAMIENTO
                            return
                            <ns2:COMPORTAMIENTO>{fn:data($COMPORTAMIENTO)}</ns2:COMPORTAMIENTO>
                        }
                        {
                            for $CATEGORIA in $DEUDAS_CANCELADAS/ns1:CATEGORIA
                            return
                            <ns2:CATEGORIA>{fn:data($CATEGORIA)}</ns2:CATEGORIA>
                        }
                </ns2:DEUDAS_CANCELADAS>
                )
            }
            </ns2:SIRC>
        </ns2:getDataBurosPreCreditGTResponse>
};

local:GetDataBurosPreCreditGT_PS_Request($ConsultaBurosResponse)