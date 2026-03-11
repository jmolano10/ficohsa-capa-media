#!/usr/bin/env python3
import sys
from pathlib import Path

try:
    from reportlab.lib.pagesizes import letter, A4
    from reportlab.lib.styles import getSampleStyleSheet, ParagraphStyle
    from reportlab.lib.units import inch
    from reportlab.platypus import SimpleDocTemplate, Paragraph, Spacer, Table, TableStyle, PageBreak
    from reportlab.lib import colors
    from reportlab.lib.enums import TA_LEFT, TA_CENTER, TA_JUSTIFY
except ImportError:
    print("Instalando reportlab...")
    import subprocess
    subprocess.check_call([sys.executable, "-m", "pip", "install", "reportlab", "-q"])
    from reportlab.lib.pagesizes import letter, A4
    from reportlab.lib.styles import getSampleStyleSheet, ParagraphStyle
    from reportlab.lib.units import inch
    from reportlab.platypus import SimpleDocTemplate, Paragraph, Spacer, Table, TableStyle, PageBreak
    from reportlab.lib import colors
    from reportlab.lib.enums import TA_LEFT, TA_CENTER, TA_JUSTIFY

def create_pdf():
    output_path = Path(__file__).parent / "Analisis_Migracion_AWS_Corresponsales_Bancarios.pdf"
    doc = SimpleDocTemplate(str(output_path), pagesize=A4, topMargin=0.5*inch, bottomMargin=0.5*inch)
    
    story = []
    styles = getSampleStyleSheet()
    
    # Estilos personalizados
    title_style = ParagraphStyle(
        'CustomTitle',
        parent=styles['Heading1'],
        fontSize=18,
        textColor=colors.HexColor('#232F3E'),
        spaceAfter=20,
        alignment=TA_CENTER
    )
    
    heading_style = ParagraphStyle(
        'CustomHeading',
        parent=styles['Heading2'],
        fontSize=14,
        textColor=colors.HexColor('#232F3E'),
        spaceAfter=12,
        spaceBefore=12
    )
    
    subheading_style = ParagraphStyle(
        'CustomSubHeading',
        parent=styles['Heading3'],
        fontSize=12,
        textColor=colors.HexColor('#FF9900'),
        spaceAfter=10
    )
    
    normal_style = ParagraphStyle(
        'CustomNormal',
        parent=styles['Normal'],
        fontSize=10,
        alignment=TA_JUSTIFY
    )
    
    # Título
    story.append(Paragraph("Análisis de Migración a AWS", title_style))
    story.append(Paragraph("Sistema de Corresponsales Bancarios", title_style))
    story.append(Spacer(1, 0.3*inch))
    
    # 1. Análisis de Datos
    story.append(Paragraph("1. Análisis de Datos Actuales", heading_style))
    
    story.append(Paragraph("1.1 Tabla MW_CORRESPONSALES_BANCARIOS", subheading_style))
    story.append(Paragraph("<b>Estructura:</b> CODIGO_CORRESPONSAL (PK), NOMBRE_CORRESPONSAL, ESTADO, CUENTA_CREDITO, CUENTA_DEBITO, MONEDA_PERMITIDA, CODIGO_PAIS, CUENTA_COMISION", normal_style))
    story.append(Paragraph("<b>Características:</b> Tabla de configuración con 3 registros. Datos maestros de baja frecuencia de cambio.", normal_style))
    story.append(Spacer(1, 0.15*inch))
    
    story.append(Paragraph("1.2 Tabla MW_TRANSACCIONES_CORBAN", subheading_style))
    story.append(Paragraph("<b>Estructura:</b> CODIGO_CORRESPONSAL (FK), CODIGO_TRANSACCION, DESCRIPCION, ESTADO, MONTO_MAX_X_TRN, TIPO_TRANSACCION, CODIGO_PAIS, MONTO_COMISION, MONEDA_COMISION, TIPO_TRANSACCION_COMISION", normal_style))
    story.append(Paragraph("<b>Características:</b> Tabla de configuración con 27 registros. Define tipos de transacciones permitidas por corresponsal.", normal_style))
    story.append(Spacer(1, 0.15*inch))
    
    story.append(Paragraph("1.3 Stored Procedure MW_P_VALIDA_CORBAN", subheading_style))
    story.append(Paragraph("<b>Funcionalidad:</b> Valida existencia y estado del corresponsal bancario, recupera configuración de cuentas (crédito, débito, comisión), valida tipo de transacción permitida, retorna información de comisiones y monedas, manejo de errores con códigos y mensajes descriptivos.", normal_style))
    story.append(Paragraph("<b>Patrón:</b> Consulta de validación y configuración (READ-ONLY), sin lógica de negocio compleja.", normal_style))
    story.append(Spacer(1, 0.2*inch))
    
    # 2. Comparativa
    story.append(Paragraph("2. Comparativa de Servicios AWS", heading_style))
    
    data = [
        ['Servicio', 'Ventajas', 'Desventajas', 'Costo'],
        ['Amazon RDS\n(Oracle/PostgreSQL)', 
         '• Migración directa\n• Soporte SQL completo\n• Backups automáticos\n• Multi-AZ HA',
         '• Mayor costo\n• Gestión de instancias\n• Escalabilidad limitada',
         '$$$-$$$$'],
        ['Aurora Serverless v2',
         '• Auto-escalado\n• Compatible PostgreSQL\n• Pago por uso\n• Alta disponibilidad',
         '• Refactorización desde Oracle\n• Curva de aprendizaje',
         '$$-$$$'],
        ['DynamoDB',
         '• Totalmente serverless\n• Latencia milisegundos\n• Escalado ilimitado\n• Cero administración',
         '• No soporta SQL nativo\n• Requiere rediseño\n• Consultas complejas limitadas',
         '$-$$'],
        ['S3 + Athena',
         '• Costo muy bajo\n• Almacenamiento ilimitado\n• Consultas SQL',
         '• No transaccional\n• Mayor latencia\n• No para escrituras frecuentes',
         '$'],
        ['ElastiCache Redis',
         '• Latencia sub-milisegundo\n• Ideal para caché\n• Alta disponibilidad',
         '• No es BD primaria\n• Requiere persistencia adicional',
         '$$']
    ]
    
    table = Table(data, colWidths=[1.5*inch, 2.2*inch, 2.2*inch, 0.8*inch])
    table.setStyle(TableStyle([
        ('BACKGROUND', (0, 0), (-1, 0), colors.HexColor('#232F3E')),
        ('TEXTCOLOR', (0, 0), (-1, 0), colors.whitesmoke),
        ('ALIGN', (0, 0), (-1, -1), 'LEFT'),
        ('VALIGN', (0, 0), (-1, -1), 'TOP'),
        ('FONTNAME', (0, 0), (-1, 0), 'Helvetica-Bold'),
        ('FONTSIZE', (0, 0), (-1, 0), 9),
        ('FONTSIZE', (0, 1), (-1, -1), 8),
        ('BOTTOMPADDING', (0, 0), (-1, 0), 12),
        ('BACKGROUND', (0, 1), (-1, -1), colors.beige),
        ('GRID', (0, 0), (-1, -1), 1, colors.black),
        ('ROWBACKGROUNDS', (0, 1), (-1, -1), [colors.white, colors.lightgrey])
    ]))
    
    story.append(table)
    story.append(Spacer(1, 0.2*inch))
    
    # 3. Mejor Opción
    story.append(Paragraph("3. Mejor Opción Recomendada: Amazon DynamoDB", heading_style))
    
    story.append(Paragraph("<b>Justificación:</b>", subheading_style))
    justification = """
    • <b>Naturaleza de los datos:</b> Tablas de configuración pequeñas (30 registros totales) con baja frecuencia de cambios<br/>
    • <b>Patrón de acceso:</b> Consultas simples por clave primaria<br/>
    • <b>Escalabilidad:</b> DynamoDB escala automáticamente sin intervención<br/>
    • <b>Costo:</b> Para este volumen, el costo mensual sería &lt; $5 USD<br/>
    • <b>Disponibilidad:</b> 99.99% SLA sin configuración adicional<br/>
    • <b>Latencia:</b> Respuestas en milisegundos, ideal para validaciones en tiempo real<br/>
    • <b>Mantenimiento:</b> Cero administración de infraestructura<br/>
    • <b>Multi-región:</b> Global Tables permite replicación automática
    """
    story.append(Paragraph(justification, normal_style))
    story.append(Spacer(1, 0.15*inch))
    
    story.append(Paragraph("<b>Diseño de Tablas en DynamoDB:</b>", subheading_style))
    story.append(Paragraph("<b>Tabla 1: CorresponsalesBancarios</b><br/>• Partition Key: CODIGO_CORRESPONSAL#CODIGO_PAIS<br/>• Atributos: nombre_corresponsal, estado, cuenta_credito, cuenta_debito, moneda_permitida, cuenta_comision", normal_style))
    story.append(Spacer(1, 0.1*inch))
    story.append(Paragraph("<b>Tabla 2: TransaccionesCorban</b><br/>• Partition Key: CODIGO_CORRESPONSAL#CODIGO_PAIS<br/>• Sort Key: CODIGO_TRANSACCION<br/>• Atributos: descripcion, estado, monto_max_x_trn, tipo_transaccion, monto_comision, moneda_comision, tipo_transaccion_comision", normal_style))
    story.append(Spacer(1, 0.15*inch))
    
    story.append(Paragraph("<b>Alternativa Híbrida (Recomendada para Producción):</b>", subheading_style))
    story.append(Paragraph("DynamoDB + ElastiCache (Redis) - DynamoDB como fuente de verdad persistente, Redis como caché de primer nivel para latencia ultra-baja, TTL de 1 hora en caché, costo adicional mínimo (~$15-20/mes), latencia &lt; 1ms en el 99% de consultas.", normal_style))
    
    story.append(PageBreak())
    
    # 4. Arquitectura
    story.append(Paragraph("4. Arquitectura para la Lógica del Stored Procedure", heading_style))
    
    arch_data = [
        ['Opción', 'Ventajas', 'Desventajas', 'Recomendación'],
        ['Stored Procedure\n(RDS/Aurora)',
         '• Migración rápida\n• Lógica centralizada\n• Menos cambios',
         '• Acoplamiento a BD\n• Difícil testear\n• No serverless',
         '❌ No recomendado'],
        ['API REST\n(API Gateway + Lambda)',
         '• Desacoplamiento\n• Serverless\n• Fácil versionamiento\n• Testing simple\n• Auto-escalable',
         '• Desarrollo nuevo\n• Cold start Lambda',
         '✅ ALTAMENTE\nRECOMENDADO'],
        ['Lambda Directa',
         '• Menor latencia\n• Menor costo\n• Invocación directa',
         '• No expone HTTP\n• Requiere SDK AWS',
         '⚠️ Solo sin HTTP'],
        ['Step Functions',
         '• Orquestación visual\n• Manejo errores robusto',
         '• Overkill para lógica simple\n• Mayor costo',
         '❌ No necesario']
    ]
    
    arch_table = Table(arch_data, colWidths=[1.5*inch, 2*inch, 2*inch, 1.2*inch])
    arch_table.setStyle(TableStyle([
        ('BACKGROUND', (0, 0), (-1, 0), colors.HexColor('#232F3E')),
        ('TEXTCOLOR', (0, 0), (-1, 0), colors.whitesmoke),
        ('ALIGN', (0, 0), (-1, -1), 'LEFT'),
        ('VALIGN', (0, 0), (-1, -1), 'TOP'),
        ('FONTNAME', (0, 0), (-1, 0), 'Helvetica-Bold'),
        ('FONTSIZE', (0, 0), (-1, 0), 9),
        ('FONTSIZE', (0, 1), (-1, -1), 8),
        ('BOTTOMPADDING', (0, 0), (-1, 0), 12),
        ('GRID', (0, 0), (-1, -1), 1, colors.black),
        ('ROWBACKGROUNDS', (0, 1), (-1, -1), [colors.white, colors.lightgrey])
    ]))
    
    story.append(arch_table)
    story.append(Spacer(1, 0.2*inch))
    
    # 5. Arquitectura Recomendada
    story.append(Paragraph("5. Arquitectura Recomendada Final", heading_style))
    story.append(Paragraph("<b>Opción Óptima: API REST Serverless con Caché</b>", subheading_style))
    
    components = """
    <b>Componentes:</b><br/>
    1. <b>Amazon API Gateway (REST API)</b> - Endpoint: POST /api/v1/corresponsales/validar, Autenticación: API Key + IAM, Throttling: 1000 req/seg<br/>
    2. <b>AWS Lambda (Python 3.12 o Node.js 20)</b> - Función: ValidarCorresponsalFunction, Memoria: 256 MB, Timeout: 10 segundos<br/>
    3. <b>Amazon ElastiCache (Redis)</b> - Instancia: cache.t4g.micro, TTL: 3600 segundos, Patrón: Cache-Aside<br/>
    4. <b>Amazon DynamoDB</b> - Modo: On-Demand, Tablas: CorresponsalesBancarios, TransaccionesCorban, Backup: PITR habilitado<br/>
    5. <b>Amazon CloudWatch</b> - Logs de Lambda, Métricas personalizadas, Alarmas de errores<br/>
    6. <b>AWS X-Ray</b> - Trazabilidad end-to-end, Análisis de latencia
    """
    story.append(Paragraph(components, normal_style))
    story.append(Spacer(1, 0.15*inch))
    
    story.append(Paragraph("<b>Flujo de Ejecución:</b>", subheading_style))
    flow = """
    1. Cliente invoca API Gateway con parámetros<br/>
    2. API Gateway valida autenticación y throttling<br/>
    3. Lambda recibe request y genera cache key<br/>
    4. Lambda consulta Redis (caché L1) - Si existe: retorna inmediatamente (~1ms)<br/>
    5. Si no existe en caché: Lambda consulta DynamoDB<br/>
    6. Lambda valida estado y construye respuesta<br/>
    7. Lambda almacena resultado en Redis<br/>
    8. Lambda retorna respuesta a API Gateway<br/>
    9. API Gateway retorna al cliente
    """
    story.append(Paragraph(flow, normal_style))
    story.append(Spacer(1, 0.2*inch))
    
    # 6. Costos
    story.append(Paragraph("6. Estimación de Costos Mensuales (AWS)", heading_style))
    
    cost_data = [
        ['Servicio', 'Configuración', 'Costo Mensual (USD)'],
        ['API Gateway', '1M requests/mes', '$3.50'],
        ['Lambda', '1M invocaciones, 256MB, 100ms avg', '$0.20'],
        ['DynamoDB', 'On-Demand, 1M reads, 10K writes', '$0.50'],
        ['ElastiCache Redis', 'cache.t4g.micro (1 nodo)', '$11.52'],
        ['CloudWatch Logs', '5 GB logs/mes', '$2.50'],
        ['X-Ray', '1M traces', '$5.00'],
        ['TOTAL', '', '~$23.22/mes']
    ]
    
    cost_table = Table(cost_data, colWidths=[2*inch, 2.5*inch, 1.5*inch])
    cost_table.setStyle(TableStyle([
        ('BACKGROUND', (0, 0), (-1, 0), colors.HexColor('#232F3E')),
        ('TEXTCOLOR', (0, 0), (-1, 0), colors.whitesmoke),
        ('ALIGN', (0, 0), (-1, -1), 'LEFT'),
        ('VALIGN', (0, 0), (-1, -1), 'MIDDLE'),
        ('FONTNAME', (0, 0), (-1, 0), 'Helvetica-Bold'),
        ('FONTNAME', (0, -1), (-1, -1), 'Helvetica-Bold'),
        ('FONTSIZE', (0, 0), (-1, -1), 10),
        ('BOTTOMPADDING', (0, 0), (-1, 0), 12),
        ('BACKGROUND', (0, -1), (-1, -1), colors.HexColor('#d4edda')),
        ('GRID', (0, 0), (-1, -1), 1, colors.black),
        ('ROWBACKGROUNDS', (0, 1), (-1, -2), [colors.white, colors.lightgrey])
    ]))
    
    story.append(cost_table)
    story.append(Paragraph("<i>Nota: Costos estimados para 1 millón de transacciones mensuales. Incluye Free Tier de AWS.</i>", normal_style))
    story.append(Spacer(1, 0.2*inch))
    
    # 7. Plan de Migración
    story.append(Paragraph("7. Plan de Migración Recomendado", heading_style))
    
    migration = """
    <b>Fase 1: Preparación (1 semana)</b><br/>
    • Crear tablas en DynamoDB<br/>
    • Migrar datos desde Oracle usando script Python/boto3<br/>
    • Configurar ElastiCache Redis<br/>
    • Validar integridad de datos<br/><br/>
    
    <b>Fase 2: Desarrollo (2 semanas)</b><br/>
    • Desarrollar función Lambda con lógica del SP<br/>
    • Implementar caché Redis<br/>
    • Crear API Gateway con endpoints<br/>
    • Desarrollar tests unitarios e integración<br/>
    • Configurar CloudWatch y X-Ray<br/><br/>
    
    <b>Fase 3: Testing (1 semana)</b><br/>
    • Pruebas funcionales<br/>
    • Pruebas de carga (JMeter/Gatling)<br/>
    • Validación de latencia<br/>
    • Pruebas de failover<br/><br/>
    
    <b>Fase 4: Despliegue (1 semana)</b><br/>
    • Despliegue en ambiente de staging<br/>
    • Pruebas de aceptación<br/>
    • Despliegue en producción (Blue/Green)<br/>
    • Monitoreo intensivo 24/7<br/>
    • Rollback plan preparado
    """
    story.append(Paragraph(migration, normal_style))
    story.append(Spacer(1, 0.2*inch))
    
    # 8. Ventajas
    story.append(Paragraph("8. Ventajas de la Arquitectura Propuesta", heading_style))
    
    advantages = """
    ✅ <b>Serverless:</b> Cero gestión de servidores<br/>
    ✅ <b>Auto-escalable:</b> Maneja de 1 a 1M requests sin cambios<br/>
    ✅ <b>Alta disponibilidad:</b> Multi-AZ por defecto<br/>
    ✅ <b>Bajo costo:</b> ~$23/mes vs $200+/mes con RDS<br/>
    ✅ <b>Baja latencia:</b> &lt; 10ms con caché, &lt; 50ms sin caché<br/>
    ✅ <b>Fácil mantenimiento:</b> Código versionado en Git<br/>
    ✅ <b>Testing:</b> Tests unitarios y de integración simples<br/>
    ✅ <b>Observabilidad:</b> Logs, métricas y trazas completas<br/>
    ✅ <b>Seguridad:</b> IAM, API Keys, VPC (opcional)<br/>
    ✅ <b>Multi-región:</b> Fácil replicación con Global Tables
    """
    story.append(Paragraph(advantages, normal_style))
    story.append(Spacer(1, 0.2*inch))
    
    # 9. Consideraciones
    story.append(Paragraph("9. Consideraciones Adicionales", heading_style))
    
    considerations = """
    <b>Seguridad:</b><br/>
    • Implementar AWS WAF en API Gateway para protección DDoS<br/>
    • Usar AWS Secrets Manager para credenciales<br/>
    • Habilitar encryption at rest en DynamoDB<br/>
    • Usar VPC endpoints para comunicación privada<br/><br/>
    
    <b>Monitoreo:</b><br/>
    • Alarmas CloudWatch para errores &gt; 1%<br/>
    • Alarmas para latencia p99 &gt; 100ms<br/>
    • Dashboard con métricas clave<br/>
    • SNS para notificaciones a equipo<br/><br/>
    
    <b>Disaster Recovery:</b><br/>
    • Backups automáticos de DynamoDB (PITR)<br/>
    • Replicación cross-region con Global Tables<br/>
    • Versionamiento de código Lambda<br/>
    • Infraestructura como código (Terraform/CloudFormation)
    """
    story.append(Paragraph(considerations, normal_style))
    story.append(Spacer(1, 0.2*inch))
    
    # 10. Conclusión
    story.append(Paragraph("10. Conclusión", heading_style))
    
    conclusion = """
    La migración de las tablas de corresponsales bancarios a <b>Amazon DynamoDB</b> combinado con 
    <b>ElastiCache Redis</b> y la transformación del stored procedure a una <b>API REST serverless con Lambda</b> 
    representa la mejor opción para este caso de uso.<br/><br/>
    
    Esta arquitectura ofrece el mejor balance entre <b>costo</b>, <b>rendimiento</b>, <b>escalabilidad</b> 
    y <b>mantenibilidad</b>, con un costo operativo aproximado de <b>$23 USD/mes</b> y latencias inferiores 
    a <b>10ms</b> en el 99% de las consultas.<br/><br/>
    
    El tiempo estimado de migración completa es de <b>5 semanas</b> con un equipo de 2 desarrolladores, 
    y el ROI se alcanza en menos de 3 meses comparado con mantener infraestructura tradicional.
    """
    story.append(Paragraph(conclusion, normal_style))
    
    # Build PDF
    doc.build(story)
    print(f"PDF generado exitosamente: {output_path}")
    return str(output_path)

if __name__ == "__main__":
    create_pdf()
