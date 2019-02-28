# LibreCAD project file
# (c) Ries van Twisk (librecad@rvt.dds.nl)
TEMPLATE = app

DISABLE_POSTSCRIPT = false

#uncomment to enable a Debugging menu entry for basic unit testing
#DEFINES += LC_DEBUGGING

#DEFINES += DWGSUPPORT
#DEFINES -= JWW_WRITE_SUPPORT

LC_VERSION="2.2.0-alpha"
VERSION=$${LC_VERSION}

# Store intermedia stuff somewhere else
GENERATED_DIR = ../../generated/librecad
# Use common project definitions.
include(../../common.pri)
include(./boost.pri)
include(./muparser.pri)

CONFIG += qt \
    warn_on \
    link_prl \
    verbose \
    depend_includepath

QT += core printsupport
QT -= gui widgets

CONFIG += c++11
*-g++ {
    QMAKE_CXXFLAGS += -fext-numeric-literals
}

GEN_LIB_DIR = ../../generated/lib
PRE_TARGETDEPS += $$GEN_LIB_DIR/libdxfrw.a
#		$$GEN_LIB_DIR/libjwwlib.a

DESTDIR = $${INSTALLDIR}

TARGET = dxf2pdf

# Make translations at the end of the process
unix {
    LC_VERSION=$$system([ "$(which git)x" != "x" -a -d ../../.git ] && echo "$(git describe --tags)" || echo "$${LC_VERSION}")

    macx {
#        TARGET = LibreCAD
        VERSION=$$system(echo "$${LC_VERSION}" | sed -e 's/\-.*//g')
        QMAKE_INFO_PLIST = Info.plist.app
        DEFINES += QC_APPDIR="\"LibreCAD\""
#        ICON = ../res/main/librecad.icns
#        contains(DISABLE_POSTSCRIPT, false) {
#            QMAKE_POST_LINK = /bin/sh $$_PRO_FILE_PWD_/../../scripts/postprocess-osx.sh $$OUT_PWD/$${DESTDIR}/$${TARGET}.app/ $$[QT_INSTALL_BINS];
#            QMAKE_POST_LINK += /usr/libexec/PlistBuddy -c \"Set :CFBundleGetInfoString string $${TARGET} $${LC_VERSION}\" $$OUT_PWD/$${DESTDIR}/$${TARGET}.app/Contents/Info.plist;
#        }
    }
    else {
#        TARGET = librecad
        DEFINES += QC_APPDIR="\"librecad\""
#        RC_FILE = ../res/main/librecad.icns
        contains(DISABLE_POSTSCRIPT, false) {
            QMAKE_POST_LINK = cd $$_PRO_FILE_PWD_/../.. && scripts/postprocess-unix.sh
        }
    }
}
win32 {
#    TARGET = LibreCAD
    DEFINES += QC_APPDIR="\"LibreCAD\""

    CONFIG += console

    # add MSYSGIT_DIR = PathToGitBinFolder (without quotes) in custom.pro file, for commit hash in about dialog
    !isEmpty( MSYSGIT_DIR ) {
        LC_VERSION = $$system( \"$$MSYSGIT_DIR/git.exe\" describe --tags || echo "$${LC_VERSION}")
    }

#    RC_FILE = ../res/main/librecad.rc
#    contains(DISABLE_POSTSCRIPT, false) {
#        QMAKE_POST_LINK = "$$_PRO_FILE_PWD_/../../scripts/postprocess-win.bat" $$LC_VERSION
#    }
}

DEFINES += LC_VERSION=\"$$LC_VERSION\"

# Additional libraries to load
LIBS += -L../../generated/lib  \
    -ldxfrw

INCLUDEPATH += \
    ../../libraries/libdxfrw/src \
    lib/debug \
    lib/engine \
    lib/fileio \
    lib/filters \
    lib/gui \
    lib/information \
    lib/math \
    lib/printing \
    main \
    main/console_dxf2pdf


# ################################################################################
# Library
HEADERS += \
    lib/debug/rs_debug.h \
    lib/engine/rs.h \
    lib/engine/rs_arc.h \
    lib/engine/rs_atomicentity.h \
    lib/engine/rs_block.h \
    lib/engine/rs_blocklist.h \
    lib/engine/rs_blocklistlistener.h \
    lib/engine/rs_circle.h \
    lib/engine/rs_color.h \
    lib/engine/rs_constructionline.h \
    lib/engine/rs_dimaligned.h \
    lib/engine/rs_dimangular.h \
    lib/engine/rs_dimdiametric.h \
    lib/engine/rs_dimension.h \
    lib/engine/rs_dimlinear.h \
    lib/engine/rs_dimradial.h \
    lib/engine/rs_document.h \
    lib/engine/rs_ellipse.h \
    lib/engine/rs_entity.h \
    lib/engine/rs_entitycontainer.h \
    lib/engine/rs_flags.h \
    lib/engine/rs_font.h \
    lib/engine/rs_fontchar.h \
    lib/engine/rs_fontlist.h \
    lib/engine/rs_graphic.h \
    lib/engine/rs_hatch.h \
    lib/engine/lc_hyperbola.h \
    lib/engine/rs_insert.h \
    lib/engine/rs_image.h \
    lib/engine/rs_layer.h \
    lib/engine/rs_layerlist.h \
    lib/engine/rs_layerlistlistener.h \
    lib/engine/rs_leader.h \
    lib/engine/rs_line.h \
    lib/engine/rs_mtext.h \
    lib/engine/rs_overlayline.h \
    lib/engine/rs_overlaybox.h \
    lib/engine/rs_pattern.h \
    lib/engine/rs_patternlist.h \
    lib/engine/rs_pen.h \
    lib/engine/rs_point.h \
    lib/engine/rs_polyline.h \
    lib/engine/rs_settings.h \
    lib/engine/rs_solid.h \
    lib/engine/rs_spline.h \
    lib/engine/lc_splinepoints.h \
    lib/engine/rs_system.h \
    lib/engine/rs_text.h \
    lib/engine/rs_undo.h \
    lib/engine/rs_undoable.h \
    lib/engine/rs_undocycle.h \
    lib/engine/rs_units.h \
    lib/engine/rs_utility.h \
    lib/engine/rs_variable.h \
    lib/engine/rs_variabledict.h \
    lib/engine/rs_vector.h \
    lib/fileio/rs_fileio.h \
    lib/filters/rs_filterdxfrw.h \
    lib/filters/rs_filterinterface.h \
    lib/gui/rs_graphicview.h \
    lib/gui/rs_grid.h \
    lib/gui/rs_linetypepattern.h \
    lib/gui/rs_painter.h \
    lib/gui/rs_painterqt.h \
    lib/gui/rs_staticgraphicview.h \
    lib/information/rs_locale.h \
    lib/information/rs_information.h \
    lib/information/rs_infoarea.h \
    lib/math/rs_math.h \
    lib/math/lc_quadratic.h \
    lib/engine/lc_rect.h \
    lib/printing/lc_printing.h

SOURCES += \
    lib/debug/rs_debug.cpp \
    lib/engine/rs_arc.cpp \
    lib/engine/rs_block.cpp \
    lib/engine/rs_blocklist.cpp \
    lib/engine/rs_circle.cpp \
    lib/engine/rs_constructionline.cpp \
    lib/engine/rs_dimaligned.cpp \
    lib/engine/rs_dimangular.cpp \
    lib/engine/rs_dimdiametric.cpp \
    lib/engine/rs_dimension.cpp \
    lib/engine/rs_dimlinear.cpp \
    lib/engine/rs_dimradial.cpp \
    lib/engine/rs_document.cpp \
    lib/engine/rs_ellipse.cpp \
    lib/engine/rs_entity.cpp \
    lib/engine/rs_entitycontainer.cpp \
    lib/engine/rs_font.cpp \
    lib/engine/rs_fontlist.cpp \
    lib/engine/rs_graphic.cpp \
    lib/engine/rs_hatch.cpp \
    lib/engine/lc_hyperbola.cpp \
    lib/engine/rs_insert.cpp \
    lib/engine/rs_image.cpp \
    lib/engine/rs_layer.cpp \
    lib/engine/rs_layerlist.cpp \
    lib/engine/rs_leader.cpp \
    lib/engine/rs_line.cpp \
    lib/engine/rs_mtext.cpp \
    lib/engine/rs_overlayline.cpp \
    lib/engine/rs_overlaybox.cpp \
    lib/engine/rs_pattern.cpp \
    lib/engine/rs_patternlist.cpp \
    lib/engine/rs_point.cpp \
    lib/engine/rs_polyline.cpp \
    lib/engine/rs_settings.cpp \
    lib/engine/rs_solid.cpp \
    lib/engine/rs_spline.cpp \
    lib/engine/lc_splinepoints.cpp \
    lib/engine/rs_system.cpp \
    lib/engine/rs_text.cpp \
    lib/engine/rs_undo.cpp \
    lib/engine/rs_undoable.cpp \
    lib/engine/rs_undocycle.cpp \
    lib/engine/rs_units.cpp \
    lib/engine/rs_utility.cpp \
    lib/engine/rs_variabledict.cpp \
    lib/engine/rs_vector.cpp \
    lib/fileio/rs_fileio.cpp \
    lib/filters/rs_filterdxfrw.cpp \
    lib/gui/rs_graphicview.cpp \
    lib/gui/rs_grid.cpp \
    lib/gui/rs_linetypepattern.cpp \
    lib/gui/rs_painter.cpp \
    lib/gui/rs_painterqt.cpp \
    lib/gui/rs_staticgraphicview.cpp \
    lib/information/rs_locale.cpp \
    lib/information/rs_information.cpp \
    lib/information/rs_infoarea.cpp \
    lib/math/rs_math.cpp \
    lib/math/lc_quadratic.cpp \
    lib/engine/rs_color.cpp \
    lib/engine/rs_pen.cpp \
    lib/engine/rs_atomicentity.cpp \
    lib/engine/rs_flags.cpp \
    lib/engine/lc_rect.cpp \
    lib/engine/rs.cpp \
    lib/printing/lc_printing.cpp


# ################################################################################
# Main
HEADERS += \
    main/main.h \
    main/console_dxf2pdf/console_dxf2pdf.h \
    main/console_dxf2pdf/pdf_print_loop.h

SOURCES += \
    main/main.cpp \
    main/console_dxf2pdf/console_dxf2pdf.cpp \
    main/console_dxf2pdf/pdf_print_loop.cpp

# If C99 emulation is needed, add the respective source files.
contains(DEFINES, EMU_C99) {
    !build_pass:verbose:message(Emulating C99 math features.)
    SOURCES += main/emu_c99.cpp
    HEADERS += main/emu_c99.h
}

