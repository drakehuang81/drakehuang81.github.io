
import json
import os
from reportlab.lib.pagesizes import A4
from reportlab.lib import colors
from reportlab.lib.styles import getSampleStyleSheet, ParagraphStyle
from reportlab.platypus import SimpleDocTemplate, Paragraph, Spacer, Table, TableStyle
from reportlab.lib.units import inch

# Load Data
with open('lib/l10n/app_en.arb', 'r') as f:
    data = json.load(f)

# Hardcoded contacts from lib/widgets/contact_section.dart
contacts = {
    "GitHub": "https://github.com/drakehuang81",
    "LinkedIn": "https://www.linkedin.com/in/drake-huang-b26028179",
    "X": "https://x.com/drake812860"
}

doc = SimpleDocTemplate("Resume_Drake_Huang.pdf", pagesize=A4,
                        rightMargin=inch*0.75, leftMargin=inch*0.75,
                        topMargin=inch*0.75, bottomMargin=inch*0.75)

styles = getSampleStyleSheet()

# Custom Styles
title_style = ParagraphStyle(
    'NameTitle',
    parent=styles['Heading1'],
    fontSize=24,
    spaceAfter=10,
    textColor=colors.HexColor('#24292e')
)

subtitle_style = ParagraphStyle(
    'JobTitle',
    parent=styles['Heading2'],
    fontSize=14,
    textColor=colors.HexColor('#586069'),
    spaceAfter=20
)

section_header_style = ParagraphStyle(
    'SectionHeader',
    parent=styles['Heading3'],
    fontSize=14,
    textColor=colors.HexColor('#0366d6'),
    spaceBefore=15,
    spaceAfter=10,
    borderPadding=5,
    borderColor=colors.HexColor('#e1e4e8'),
    borderWidth=0,
    bulletFontName='Helvetica-Bold'
)

normal_style = styles['Normal']
normal_style.fontSize = 10
normal_style.leading = 14

bullet_style = ParagraphStyle(
    'Bullet',
    parent=normal_style,
    bulletIndent=10,
    leftIndent=20,
    spaceAfter=2
)

job_header_style = ParagraphStyle(
    'JobHeader',
    parent=styles['Normal'],
    fontSize=11,
    fontName='Helvetica-Bold',
    spaceBefore=10,
    spaceAfter=2
)

job_meta_style = ParagraphStyle(
    'JobMeta',
    parent=styles['Normal'],
    fontSize=10,
    fontName='Helvetica-Oblique',
    textColor=colors.HexColor('#586069'),
    spaceAfter=5
)

story = []

# --- Header ---
story.append(Paragraph(data['name'], title_style))
story.append(Paragraph(data['jobTitle'], subtitle_style))

# --- Contact Info ---
contact_text = []
for k, v in contacts.items():
    contact_text.append(f'<a href="{v}" color="blue">{k}</a>')
story.append(Paragraph(" | ".join(contact_text), normal_style))
story.append(Spacer(1, 20))

# --- Summary ---
story.append(Paragraph("SUMMARY", section_header_style))
# Drawing a line under section header
story.append(Paragraph(data['aboutMeIntro'], normal_style))
story.append(Spacer(1, 6))
story.append(Paragraph(data['aboutMeIntro2'], normal_style))
story.append(Spacer(1, 10))

# --- Experience ---
story.append(Paragraph("WORK EXPERIENCE", section_header_style))

# Experience loop
i = 0
while f"job{i}Title" in data or f"job{i}Company" in data:
    title = data.get(f"job{i}Title", "")
    company = data.get(f"job{i}Company", "") 
    period = data.get(f"job{i}Period", "")
    
    # If company is missing (e.g. self-employed might be structured differently), check logic
    # Looking at arb, job0 has job0Title, job0Company.
    
    # Header: Title at Company
    if company:
        header_text = f"{title} at {company}"
    else:
        header_text = title
        
    story.append(Paragraph(header_text, job_header_style))
    story.append(Paragraph(period, job_meta_style))
    
    # Descriptions
    j = 1
    while f"job{i}Desc{j}" in data:
        desc = data[f"job{i}Desc{j}"]
        story.append(Paragraph(f"• {desc}", bullet_style))
        j += 1
    
    story.append(Spacer(1, 10))
    i += 1

# --- Education ---
if "eduSchool" in data:
    story.append(Paragraph("EDUCATION", section_header_style))
    school = data.get("eduSchool", "")
    degree = data.get("eduDegree", "")
    major = data.get("eduMajor", "")
    
    story.append(Paragraph(school, job_header_style))
    story.append(Paragraph(f"{degree} in {major}", normal_style))

doc.build(story)
print("PDF Generated Successfully: Resume_Drake_Huang.pdf")
