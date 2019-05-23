; ModuleID = 'nested_struct/main.c'
source_filename = "nested_struct/main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.S1 = type { i32, i32, i32, %struct.S2 }
%struct.S2 = type { i32*, i32*, i32* }

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 !dbg !7 {
entry:
  %retval = alloca i32, align 4
  %s1 = alloca %struct.S1, align 8
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata %struct.S1* %s1, metadata !11, metadata !DIExpression()), !dbg !24
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
  %s210 = getelementptr inbounds %struct.S1, %struct.S1* %s1, i32 0, i32 3, !dbg !50
  %y_ptr11 = getelementptr inbounds %struct.S2, %struct.S2* %s210, i32 0, i32 1, !dbg !51
  %4 = load i32*, i32** %y_ptr11, align 8, !dbg !51
  store i32 %3, i32* %4, align 4, !dbg !52
  %tobool = icmp ne i32 %3, 0, !dbg !52
  br i1 %tobool, label %land.rhs, label %land.end, !dbg !53

land.rhs:                                         ; preds = %land.lhs.true
  %z12 = getelementptr inbounds %struct.S1, %struct.S1* %s1, i32 0, i32 2, !dbg !54
  %5 = load i32, i32* %z12, align 8, !dbg !54
  %s213 = getelementptr inbounds %struct.S1, %struct.S1* %s1, i32 0, i32 3, !dbg !55
  %z_ptr14 = getelementptr inbounds %struct.S2, %struct.S2* %s213, i32 0, i32 2, !dbg !56
  %6 = load i32*, i32** %z_ptr14, align 8, !dbg !56
  store i32 %5, i32* %6, align 4, !dbg !57
  %tobool15 = icmp ne i32 %5, 0, !dbg !53
  br label %land.end

land.end:                                         ; preds = %land.rhs, %land.lhs.true, %entry
  %7 = phi i1 [ false, %land.lhs.true ], [ false, %entry ], [ %tobool15, %land.rhs ], !dbg !58
  %land.ext = zext i1 %7 to i32, !dbg !53
  %call = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %land.ext), !dbg !59
  %x16 = getelementptr inbounds %struct.S1, %struct.S1* %s1, i32 0, i32 0, !dbg !60
  %8 = load i32, i32* %x16, align 8, !dbg !61
  %add = add nsw i32 %8, 5, !dbg !61
  store i32 %add, i32* %x16, align 8, !dbg !61
  %s217 = getelementptr inbounds %struct.S1, %struct.S1* %s1, i32 0, i32 3, !dbg !62
  %x_ptr18 = getelementptr inbounds %struct.S2, %struct.S2* %s217, i32 0, i32 0, !dbg !63
  %9 = load i32*, i32** %x_ptr18, align 8, !dbg !63
  %10 = load i32, i32* %9, align 4, !dbg !64
  %s219 = getelementptr inbounds %struct.S1, %struct.S1* %s1, i32 0, i32 3, !dbg !65
  %y_ptr20 = getelementptr inbounds %struct.S2, %struct.S2* %s219, i32 0, i32 1, !dbg !66
  %11 = load i32*, i32** %y_ptr20, align 8, !dbg !66
  %12 = load i32, i32* %11, align 4, !dbg !67
  %add21 = add nsw i32 %10, %12, !dbg !68
  %s222 = getelementptr inbounds %struct.S1, %struct.S1* %s1, i32 0, i32 3, !dbg !69
  %z_ptr23 = getelementptr inbounds %struct.S2, %struct.S2* %s222, i32 0, i32 2, !dbg !70
  %13 = load i32*, i32** %z_ptr23, align 8, !dbg !70
  %14 = load i32, i32* %13, align 4, !dbg !71
  %add24 = add nsw i32 %add21, %14, !dbg !72
  %cmp25 = icmp eq i32 %add24, 30, !dbg !73
  %conv = zext i1 %cmp25 to i32, !dbg !73
  %call26 = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv), !dbg !74
  ret i32 0, !dbg !75
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

declare dso_local i32 @assert(...) #2

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 8.0.0 ", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, nameTableKind: None)
!1 = !DIFile(filename: "nested_struct/main.c", directory: "/home/akash/Documents/CBMC/cbmc/src/llvm2goto/regression")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 8.0.0 "}
!7 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 13, type: !8, scopeLine: 14, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{!10}
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !DILocalVariable(name: "s1", scope: !7, file: !1, line: 15, type: !12)
!12 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "S1", file: !1, line: 1, size: 320, elements: !13)
!13 = !{!14, !15, !16, !17}
!14 = !DIDerivedType(tag: DW_TAG_member, name: "x", scope: !12, file: !1, line: 3, baseType: !10, size: 32)
!15 = !DIDerivedType(tag: DW_TAG_member, name: "y", scope: !12, file: !1, line: 3, baseType: !10, size: 32, offset: 32)
!16 = !DIDerivedType(tag: DW_TAG_member, name: "z", scope: !12, file: !1, line: 3, baseType: !10, size: 32, offset: 64)
!17 = !DIDerivedType(tag: DW_TAG_member, name: "s2", scope: !12, file: !1, line: 10, baseType: !18, size: 192, offset: 128)
!18 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "S2", file: !1, line: 5, size: 192, elements: !19)
!19 = !{!20, !22, !23}
!20 = !DIDerivedType(tag: DW_TAG_member, name: "x_ptr", scope: !18, file: !1, line: 7, baseType: !21, size: 64)
!21 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !10, size: 64)
!22 = !DIDerivedType(tag: DW_TAG_member, name: "y_ptr", scope: !18, file: !1, line: 8, baseType: !21, size: 64, offset: 64)
!23 = !DIDerivedType(tag: DW_TAG_member, name: "z_ptr", scope: !18, file: !1, line: 9, baseType: !21, size: 64, offset: 128)
!24 = !DILocation(line: 15, column: 12, scope: !7)
!25 = !DILocation(line: 17, column: 5, scope: !7)
!26 = !DILocation(line: 17, column: 7, scope: !7)
!27 = !DILocation(line: 18, column: 5, scope: !7)
!28 = !DILocation(line: 18, column: 7, scope: !7)
!29 = !DILocation(line: 19, column: 5, scope: !7)
!30 = !DILocation(line: 19, column: 7, scope: !7)
!31 = !DILocation(line: 21, column: 21, scope: !7)
!32 = !DILocation(line: 21, column: 5, scope: !7)
!33 = !DILocation(line: 21, column: 8, scope: !7)
!34 = !DILocation(line: 21, column: 14, scope: !7)
!35 = !DILocation(line: 22, column: 21, scope: !7)
!36 = !DILocation(line: 22, column: 5, scope: !7)
!37 = !DILocation(line: 22, column: 8, scope: !7)
!38 = !DILocation(line: 22, column: 14, scope: !7)
!39 = !DILocation(line: 23, column: 21, scope: !7)
!40 = !DILocation(line: 23, column: 5, scope: !7)
!41 = !DILocation(line: 23, column: 8, scope: !7)
!42 = !DILocation(line: 23, column: 14, scope: !7)
!43 = !DILocation(line: 25, column: 15, scope: !7)
!44 = !DILocation(line: 25, column: 18, scope: !7)
!45 = !DILocation(line: 25, column: 10, scope: !7)
!46 = !DILocation(line: 25, column: 31, scope: !7)
!47 = !DILocation(line: 25, column: 25, scope: !7)
!48 = !DILocation(line: 25, column: 34, scope: !7)
!49 = !DILocation(line: 25, column: 58, scope: !7)
!50 = !DILocation(line: 25, column: 43, scope: !7)
!51 = !DILocation(line: 25, column: 46, scope: !7)
!52 = !DILocation(line: 25, column: 53, scope: !7)
!53 = !DILocation(line: 25, column: 61, scope: !7)
!54 = !DILocation(line: 25, column: 85, scope: !7)
!55 = !DILocation(line: 25, column: 70, scope: !7)
!56 = !DILocation(line: 25, column: 73, scope: !7)
!57 = !DILocation(line: 25, column: 80, scope: !7)
!58 = !DILocation(line: 0, scope: !7)
!59 = !DILocation(line: 25, column: 2, scope: !7)
!60 = !DILocation(line: 27, column: 5, scope: !7)
!61 = !DILocation(line: 27, column: 7, scope: !7)
!62 = !DILocation(line: 29, column: 14, scope: !7)
!63 = !DILocation(line: 29, column: 17, scope: !7)
!64 = !DILocation(line: 29, column: 10, scope: !7)
!65 = !DILocation(line: 29, column: 29, scope: !7)
!66 = !DILocation(line: 29, column: 32, scope: !7)
!67 = !DILocation(line: 29, column: 25, scope: !7)
!68 = !DILocation(line: 29, column: 23, scope: !7)
!69 = !DILocation(line: 29, column: 44, scope: !7)
!70 = !DILocation(line: 29, column: 47, scope: !7)
!71 = !DILocation(line: 29, column: 40, scope: !7)
!72 = !DILocation(line: 29, column: 38, scope: !7)
!73 = !DILocation(line: 29, column: 54, scope: !7)
!74 = !DILocation(line: 29, column: 2, scope: !7)
!75 = !DILocation(line: 32, column: 2, scope: !7)
