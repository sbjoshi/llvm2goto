; ModuleID = 'nested_struct/main.c'
source_filename = "nested_struct/main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.S1 = type { i32, i32, i32, %struct.S2 }
%struct.S2 = type { i32*, i32*, i32* }

; Function Attrs: noinline nounwind uwtable
define i32 @main() #0 !dbg !6 {
entry:
  %retval = alloca i32, align 4
  %s1 = alloca %struct.S1, align 8
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata %struct.S1* %s1, metadata !10, metadata !23), !dbg !24
  %x = getelementptr inbounds %struct.S1, %struct.S1* %s1, i32 0, i32 0, !dbg !25
  store i32 5, i32* %x, align 8, !dbg !26
  %y = getelementptr inbounds %struct.S1, %struct.S1* %s1, i32 0, i32 1, !dbg !27
  store i32 10, i32* %y, align 4, !dbg !28
  %z = getelementptr inbounds %struct.S1, %struct.S1* %s1, i32 0, i32 2, !dbg !29
  store i32 10, i32* %z, align 8, !dbg !30
  %x1 = getelementptr inbounds %struct.S1, %struct.S1* %s1, i32 0, i32 0, !dbg !31
  %s2 = getelementptr inbounds %struct.S1, %struct.S1* %s1, i32 0, i32 3, !dbg !32
  %x_ptr = getelementptr inbounds %struct.S2, %struct.S2* %s2, i32 0, i32 0, !dbg !33
  store i32* %x1, i32** %x_ptr, align 8, !dbg !34
  %y2 = getelementptr inbounds %struct.S1, %struct.S1* %s1, i32 0, i32 1, !dbg !35
  %s23 = getelementptr inbounds %struct.S1, %struct.S1* %s1, i32 0, i32 3, !dbg !36
  %y_ptr = getelementptr inbounds %struct.S2, %struct.S2* %s23, i32 0, i32 1, !dbg !37
  store i32* %y2, i32** %y_ptr, align 8, !dbg !38
  %z4 = getelementptr inbounds %struct.S1, %struct.S1* %s1, i32 0, i32 2, !dbg !39
  %s25 = getelementptr inbounds %struct.S1, %struct.S1* %s1, i32 0, i32 3, !dbg !40
  %z_ptr = getelementptr inbounds %struct.S2, %struct.S2* %s25, i32 0, i32 2, !dbg !41
  store i32* %z4, i32** %z_ptr, align 8, !dbg !42
  %s26 = getelementptr inbounds %struct.S1, %struct.S1* %s1, i32 0, i32 3, !dbg !43
  %x_ptr7 = getelementptr inbounds %struct.S2, %struct.S2* %s26, i32 0, i32 0, !dbg !44
  %0 = load i32*, i32** %x_ptr7, align 8, !dbg !44
  %1 = load i32, i32* %0, align 4, !dbg !45
  %x8 = getelementptr inbounds %struct.S1, %struct.S1* %s1, i32 0, i32 0, !dbg !46
  %2 = load i32, i32* %x8, align 8, !dbg !46
  %cmp = icmp eq i32 %1, %2, !dbg !47
  br i1 %cmp, label %land.lhs.true, label %land.end, !dbg !48

land.lhs.true:                                    ; preds = %entry
  %y9 = getelementptr inbounds %struct.S1, %struct.S1* %s1, i32 0, i32 1, !dbg !49
  %3 = load i32, i32* %y9, align 4, !dbg !49
  %s210 = getelementptr inbounds %struct.S1, %struct.S1* %s1, i32 0, i32 3, !dbg !51
  %y_ptr11 = getelementptr inbounds %struct.S2, %struct.S2* %s210, i32 0, i32 1, !dbg !52
  %4 = load i32*, i32** %y_ptr11, align 8, !dbg !52
  store i32 %3, i32* %4, align 4, !dbg !53
  %tobool = icmp ne i32 %3, 0, !dbg !53
  br i1 %tobool, label %land.rhs, label %land.end, !dbg !54

land.rhs:                                         ; preds = %land.lhs.true
  %z12 = getelementptr inbounds %struct.S1, %struct.S1* %s1, i32 0, i32 2, !dbg !55
  %5 = load i32, i32* %z12, align 8, !dbg !55
  %s213 = getelementptr inbounds %struct.S1, %struct.S1* %s1, i32 0, i32 3, !dbg !57
  %z_ptr14 = getelementptr inbounds %struct.S2, %struct.S2* %s213, i32 0, i32 2, !dbg !58
  %6 = load i32*, i32** %z_ptr14, align 8, !dbg !58
  store i32 %5, i32* %6, align 4, !dbg !59
  %tobool15 = icmp ne i32 %5, 0, !dbg !60
  br label %land.end

land.end:                                         ; preds = %land.rhs, %land.lhs.true, %entry
  %7 = phi i1 [ false, %land.lhs.true ], [ false, %entry ], [ %tobool15, %land.rhs ]
  %land.ext = zext i1 %7 to i32, !dbg !61
  %call = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %land.ext), !dbg !63
  %x16 = getelementptr inbounds %struct.S1, %struct.S1* %s1, i32 0, i32 0, !dbg !64
  %8 = load i32, i32* %x16, align 8, !dbg !65
  %add = add nsw i32 %8, 5, !dbg !65
  store i32 %add, i32* %x16, align 8, !dbg !65
  %s217 = getelementptr inbounds %struct.S1, %struct.S1* %s1, i32 0, i32 3, !dbg !66
  %x_ptr18 = getelementptr inbounds %struct.S2, %struct.S2* %s217, i32 0, i32 0, !dbg !67
  %9 = load i32*, i32** %x_ptr18, align 8, !dbg !67
  %10 = load i32, i32* %9, align 4, !dbg !68
  %s219 = getelementptr inbounds %struct.S1, %struct.S1* %s1, i32 0, i32 3, !dbg !69
  %y_ptr20 = getelementptr inbounds %struct.S2, %struct.S2* %s219, i32 0, i32 1, !dbg !70
  %11 = load i32*, i32** %y_ptr20, align 8, !dbg !70
  %12 = load i32, i32* %11, align 4, !dbg !71
  %add21 = add nsw i32 %10, %12, !dbg !72
  %s222 = getelementptr inbounds %struct.S1, %struct.S1* %s1, i32 0, i32 3, !dbg !73
  %z_ptr23 = getelementptr inbounds %struct.S2, %struct.S2* %s222, i32 0, i32 2, !dbg !74
  %13 = load i32*, i32** %z_ptr23, align 8, !dbg !74
  %14 = load i32, i32* %13, align 4, !dbg !75
  %add24 = add nsw i32 %add21, %14, !dbg !76
  %cmp25 = icmp eq i32 %add24, 30, !dbg !77
  %conv = zext i1 %cmp25 to i32, !dbg !77
  %call26 = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv), !dbg !78
  ret i32 0, !dbg !79
}

; Function Attrs: nounwind readnone
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

declare i32 @assert(...) #2

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4}
!llvm.ident = !{!5}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.0 (trunk 295264)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2)
!1 = !DIFile(filename: "nested_struct/main.c", directory: "/home/rasika/llvm2goto/llvm2goto-regression-master")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{!"clang version 5.0.0 (trunk 295264)"}
!6 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 13, type: !7, isLocal: false, isDefinition: true, scopeLine: 14, isOptimized: false, unit: !0, variables: !2)
!7 = !DISubroutineType(types: !8)
!8 = !{!9}
!9 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!10 = !DILocalVariable(name: "s1", scope: !6, file: !1, line: 15, type: !11)
!11 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "S1", file: !1, line: 1, size: 320, elements: !12)
!12 = !{!13, !14, !15, !16}
!13 = !DIDerivedType(tag: DW_TAG_member, name: "x", scope: !11, file: !1, line: 3, baseType: !9, size: 32)
!14 = !DIDerivedType(tag: DW_TAG_member, name: "y", scope: !11, file: !1, line: 3, baseType: !9, size: 32, offset: 32)
!15 = !DIDerivedType(tag: DW_TAG_member, name: "z", scope: !11, file: !1, line: 3, baseType: !9, size: 32, offset: 64)
!16 = !DIDerivedType(tag: DW_TAG_member, name: "s2", scope: !11, file: !1, line: 10, baseType: !17, size: 192, offset: 128)
!17 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "S2", file: !1, line: 5, size: 192, elements: !18)
!18 = !{!19, !21, !22}
!19 = !DIDerivedType(tag: DW_TAG_member, name: "x_ptr", scope: !17, file: !1, line: 7, baseType: !20, size: 64)
!20 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !9, size: 64)
!21 = !DIDerivedType(tag: DW_TAG_member, name: "y_ptr", scope: !17, file: !1, line: 8, baseType: !20, size: 64, offset: 64)
!22 = !DIDerivedType(tag: DW_TAG_member, name: "z_ptr", scope: !17, file: !1, line: 9, baseType: !20, size: 64, offset: 128)
!23 = !DIExpression()
!24 = !DILocation(line: 15, column: 12, scope: !6)
!25 = !DILocation(line: 17, column: 5, scope: !6)
!26 = !DILocation(line: 17, column: 7, scope: !6)
!27 = !DILocation(line: 18, column: 5, scope: !6)
!28 = !DILocation(line: 18, column: 7, scope: !6)
!29 = !DILocation(line: 19, column: 5, scope: !6)
!30 = !DILocation(line: 19, column: 7, scope: !6)
!31 = !DILocation(line: 21, column: 21, scope: !6)
!32 = !DILocation(line: 21, column: 5, scope: !6)
!33 = !DILocation(line: 21, column: 8, scope: !6)
!34 = !DILocation(line: 21, column: 14, scope: !6)
!35 = !DILocation(line: 22, column: 21, scope: !6)
!36 = !DILocation(line: 22, column: 5, scope: !6)
!37 = !DILocation(line: 22, column: 8, scope: !6)
!38 = !DILocation(line: 22, column: 14, scope: !6)
!39 = !DILocation(line: 23, column: 21, scope: !6)
!40 = !DILocation(line: 23, column: 5, scope: !6)
!41 = !DILocation(line: 23, column: 8, scope: !6)
!42 = !DILocation(line: 23, column: 14, scope: !6)
!43 = !DILocation(line: 25, column: 15, scope: !6)
!44 = !DILocation(line: 25, column: 18, scope: !6)
!45 = !DILocation(line: 25, column: 10, scope: !6)
!46 = !DILocation(line: 25, column: 31, scope: !6)
!47 = !DILocation(line: 25, column: 25, scope: !6)
!48 = !DILocation(line: 25, column: 34, scope: !6)
!49 = !DILocation(line: 25, column: 58, scope: !50)
!50 = !DILexicalBlockFile(scope: !6, file: !1, discriminator: 2)
!51 = !DILocation(line: 25, column: 43, scope: !50)
!52 = !DILocation(line: 25, column: 46, scope: !50)
!53 = !DILocation(line: 25, column: 53, scope: !50)
!54 = !DILocation(line: 25, column: 61, scope: !50)
!55 = !DILocation(line: 25, column: 85, scope: !56)
!56 = !DILexicalBlockFile(scope: !6, file: !1, discriminator: 4)
!57 = !DILocation(line: 25, column: 70, scope: !56)
!58 = !DILocation(line: 25, column: 73, scope: !56)
!59 = !DILocation(line: 25, column: 80, scope: !56)
!60 = !DILocation(line: 25, column: 61, scope: !56)
!61 = !DILocation(line: 25, column: 61, scope: !62)
!62 = !DILexicalBlockFile(scope: !6, file: !1, discriminator: 6)
!63 = !DILocation(line: 25, column: 2, scope: !62)
!64 = !DILocation(line: 27, column: 5, scope: !6)
!65 = !DILocation(line: 27, column: 7, scope: !6)
!66 = !DILocation(line: 29, column: 14, scope: !6)
!67 = !DILocation(line: 29, column: 17, scope: !6)
!68 = !DILocation(line: 29, column: 10, scope: !6)
!69 = !DILocation(line: 29, column: 29, scope: !6)
!70 = !DILocation(line: 29, column: 32, scope: !6)
!71 = !DILocation(line: 29, column: 25, scope: !6)
!72 = !DILocation(line: 29, column: 23, scope: !6)
!73 = !DILocation(line: 29, column: 44, scope: !6)
!74 = !DILocation(line: 29, column: 47, scope: !6)
!75 = !DILocation(line: 29, column: 40, scope: !6)
!76 = !DILocation(line: 29, column: 38, scope: !6)
!77 = !DILocation(line: 29, column: 54, scope: !6)
!78 = !DILocation(line: 29, column: 2, scope: !6)
!79 = !DILocation(line: 32, column: 2, scope: !6)
