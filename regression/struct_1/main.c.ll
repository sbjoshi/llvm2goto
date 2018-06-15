; ModuleID = 'struct_1/main.c'
source_filename = "struct_1/main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.Simple = type { i32, i32, i32 }

@.str = private unnamed_addr constant [57 x i8] c"obj1.a == obj2.a && obj1.b == obj2.b && obj1.c == obj2.c\00", align 1
@.str.1 = private unnamed_addr constant [16 x i8] c"struct_1/main.c\00", align 1
@__PRETTY_FUNCTION__.main = private unnamed_addr constant [11 x i8] c"int main()\00", align 1
@.str.2 = private unnamed_addr constant [57 x i8] c"obj1.a == obj2.a && obj1.b == obj2.b && obj3.c == obj3.c\00", align 1

; Function Attrs: noinline nounwind uwtable
define i32 @main() #0 !dbg !6 {
entry:
  %retval = alloca i32, align 4
  %a1 = alloca i32, align 4
  %b1 = alloca i32, align 4
  %c1 = alloca i32, align 4
  %obj1 = alloca %struct.Simple, align 4
  %obj2 = alloca %struct.Simple, align 4
  %obj3 = alloca %struct.Simple, align 4
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata i32* %a1, metadata !10, metadata !11), !dbg !12
  call void @llvm.dbg.declare(metadata i32* %b1, metadata !13, metadata !11), !dbg !14
  call void @llvm.dbg.declare(metadata i32* %c1, metadata !15, metadata !11), !dbg !16
  call void @llvm.dbg.declare(metadata %struct.Simple* %obj1, metadata !17, metadata !11), !dbg !23
  %0 = load i32, i32* %a1, align 4, !dbg !24
  %a = getelementptr inbounds %struct.Simple, %struct.Simple* %obj1, i32 0, i32 0, !dbg !25
  store i32 %0, i32* %a, align 4, !dbg !26
  %1 = load i32, i32* %b1, align 4, !dbg !27
  %b = getelementptr inbounds %struct.Simple, %struct.Simple* %obj1, i32 0, i32 1, !dbg !28
  store i32 %1, i32* %b, align 4, !dbg !29
  %2 = load i32, i32* %c1, align 4, !dbg !30
  %c = getelementptr inbounds %struct.Simple, %struct.Simple* %obj1, i32 0, i32 2, !dbg !31
  store i32 %2, i32* %c, align 4, !dbg !32
  call void @llvm.dbg.declare(metadata %struct.Simple* %obj2, metadata !33, metadata !11), !dbg !34
  %a2 = getelementptr inbounds %struct.Simple, %struct.Simple* %obj1, i32 0, i32 0, !dbg !35
  %3 = load i32, i32* %a2, align 4, !dbg !35
  %a3 = getelementptr inbounds %struct.Simple, %struct.Simple* %obj2, i32 0, i32 0, !dbg !36
  store i32 %3, i32* %a3, align 4, !dbg !37
  %b4 = getelementptr inbounds %struct.Simple, %struct.Simple* %obj1, i32 0, i32 1, !dbg !38
  %4 = load i32, i32* %b4, align 4, !dbg !38
  %b5 = getelementptr inbounds %struct.Simple, %struct.Simple* %obj2, i32 0, i32 1, !dbg !39
  store i32 %4, i32* %b5, align 4, !dbg !40
  %c6 = getelementptr inbounds %struct.Simple, %struct.Simple* %obj1, i32 0, i32 2, !dbg !41
  %5 = load i32, i32* %c6, align 4, !dbg !41
  %c7 = getelementptr inbounds %struct.Simple, %struct.Simple* %obj2, i32 0, i32 2, !dbg !42
  store i32 %5, i32* %c7, align 4, !dbg !43
  %a8 = getelementptr inbounds %struct.Simple, %struct.Simple* %obj1, i32 0, i32 0, !dbg !44
  %6 = load i32, i32* %a8, align 4, !dbg !44
  %a9 = getelementptr inbounds %struct.Simple, %struct.Simple* %obj2, i32 0, i32 0, !dbg !44
  %7 = load i32, i32* %a9, align 4, !dbg !44
  %cmp = icmp eq i32 %6, %7, !dbg !44
  br i1 %cmp, label %land.lhs.true, label %cond.false, !dbg !44

land.lhs.true:                                    ; preds = %entry
  %b10 = getelementptr inbounds %struct.Simple, %struct.Simple* %obj1, i32 0, i32 1, !dbg !45
  %8 = load i32, i32* %b10, align 4, !dbg !45
  %b11 = getelementptr inbounds %struct.Simple, %struct.Simple* %obj2, i32 0, i32 1, !dbg !45
  %9 = load i32, i32* %b11, align 4, !dbg !45
  %cmp12 = icmp eq i32 %8, %9, !dbg !45
  br i1 %cmp12, label %land.lhs.true13, label %cond.false, !dbg !45

land.lhs.true13:                                  ; preds = %land.lhs.true
  %c14 = getelementptr inbounds %struct.Simple, %struct.Simple* %obj1, i32 0, i32 2, !dbg !47
  %10 = load i32, i32* %c14, align 4, !dbg !47
  %c15 = getelementptr inbounds %struct.Simple, %struct.Simple* %obj2, i32 0, i32 2, !dbg !47
  %11 = load i32, i32* %c15, align 4, !dbg !47
  %cmp16 = icmp eq i32 %10, %11, !dbg !47
  br i1 %cmp16, label %cond.true, label %cond.false, !dbg !47

cond.true:                                        ; preds = %land.lhs.true13
  br label %cond.end, !dbg !49

cond.false:                                       ; preds = %land.lhs.true13, %land.lhs.true, %entry
  call void @__assert_fail(i8* getelementptr inbounds ([57 x i8], [57 x i8]* @.str, i32 0, i32 0), i8* getelementptr inbounds ([16 x i8], [16 x i8]* @.str.1, i32 0, i32 0), i32 22, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @__PRETTY_FUNCTION__.main, i32 0, i32 0)) #3, !dbg !51
  unreachable, !dbg !51
                                                  ; No predecessors!
  br label %cond.end, !dbg !53

cond.end:                                         ; preds = %12, %cond.true
  call void @llvm.dbg.declare(metadata %struct.Simple* %obj3, metadata !55, metadata !11), !dbg !56
  %a17 = getelementptr inbounds %struct.Simple, %struct.Simple* %obj3, i32 0, i32 0, !dbg !57
  %13 = load i32, i32* %a1, align 4, !dbg !58
  store i32 %13, i32* %a17, align 4, !dbg !57
  %b18 = getelementptr inbounds %struct.Simple, %struct.Simple* %obj3, i32 0, i32 1, !dbg !57
  %14 = load i32, i32* %b1, align 4, !dbg !59
  store i32 %14, i32* %b18, align 4, !dbg !57
  %c19 = getelementptr inbounds %struct.Simple, %struct.Simple* %obj3, i32 0, i32 2, !dbg !57
  %15 = load i32, i32* %c1, align 4, !dbg !60
  store i32 %15, i32* %c19, align 4, !dbg !57
  %a20 = getelementptr inbounds %struct.Simple, %struct.Simple* %obj1, i32 0, i32 0, !dbg !61
  %16 = load i32, i32* %a20, align 4, !dbg !61
  %a21 = getelementptr inbounds %struct.Simple, %struct.Simple* %obj2, i32 0, i32 0, !dbg !61
  %17 = load i32, i32* %a21, align 4, !dbg !61
  %cmp22 = icmp eq i32 %16, %17, !dbg !61
  br i1 %cmp22, label %land.lhs.true23, label %cond.false32, !dbg !61

land.lhs.true23:                                  ; preds = %cond.end
  %b24 = getelementptr inbounds %struct.Simple, %struct.Simple* %obj1, i32 0, i32 1, !dbg !62
  %18 = load i32, i32* %b24, align 4, !dbg !62
  %b25 = getelementptr inbounds %struct.Simple, %struct.Simple* %obj2, i32 0, i32 1, !dbg !62
  %19 = load i32, i32* %b25, align 4, !dbg !62
  %cmp26 = icmp eq i32 %18, %19, !dbg !62
  br i1 %cmp26, label %land.lhs.true27, label %cond.false32, !dbg !62

land.lhs.true27:                                  ; preds = %land.lhs.true23
  %c28 = getelementptr inbounds %struct.Simple, %struct.Simple* %obj3, i32 0, i32 2, !dbg !63
  %20 = load i32, i32* %c28, align 4, !dbg !63
  %c29 = getelementptr inbounds %struct.Simple, %struct.Simple* %obj3, i32 0, i32 2, !dbg !63
  %21 = load i32, i32* %c29, align 4, !dbg !63
  %cmp30 = icmp eq i32 %20, %21, !dbg !63
  br i1 %cmp30, label %cond.true31, label %cond.false32, !dbg !63

cond.true31:                                      ; preds = %land.lhs.true27
  br label %cond.end33, !dbg !64

cond.false32:                                     ; preds = %land.lhs.true27, %land.lhs.true23, %cond.end
  call void @__assert_fail(i8* getelementptr inbounds ([57 x i8], [57 x i8]* @.str.2, i32 0, i32 0), i8* getelementptr inbounds ([16 x i8], [16 x i8]* @.str.1, i32 0, i32 0), i32 29, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @__PRETTY_FUNCTION__.main, i32 0, i32 0)) #3, !dbg !65
  unreachable, !dbg !65
                                                  ; No predecessors!
  br label %cond.end33, !dbg !66

cond.end33:                                       ; preds = %22, %cond.true31
  ret i32 0, !dbg !67
}

; Function Attrs: nounwind readnone
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noreturn nounwind
declare void @__assert_fail(i8*, i8*, i32, i8*) #2

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone }
attributes #2 = { noreturn nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { noreturn nounwind }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4}
!llvm.ident = !{!5}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.0 (trunk 295264)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2)
!1 = !DIFile(filename: "struct_1/main.c", directory: "/home/rasika/llvm2goto/llvm2goto-regression-master")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{!"clang version 5.0.0 (trunk 295264)"}
!6 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 8, type: !7, isLocal: false, isDefinition: true, scopeLine: 9, isOptimized: false, unit: !0, variables: !2)
!7 = !DISubroutineType(types: !8)
!8 = !{!9}
!9 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!10 = !DILocalVariable(name: "a1", scope: !6, file: !1, line: 10, type: !9)
!11 = !DIExpression()
!12 = !DILocation(line: 10, column: 6, scope: !6)
!13 = !DILocalVariable(name: "b1", scope: !6, file: !1, line: 10, type: !9)
!14 = !DILocation(line: 10, column: 9, scope: !6)
!15 = !DILocalVariable(name: "c1", scope: !6, file: !1, line: 10, type: !9)
!16 = !DILocation(line: 10, column: 12, scope: !6)
!17 = !DILocalVariable(name: "obj1", scope: !6, file: !1, line: 12, type: !18)
!18 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "Simple", file: !1, line: 3, size: 96, elements: !19)
!19 = !{!20, !21, !22}
!20 = !DIDerivedType(tag: DW_TAG_member, name: "a", scope: !18, file: !1, line: 5, baseType: !9, size: 32)
!21 = !DIDerivedType(tag: DW_TAG_member, name: "b", scope: !18, file: !1, line: 5, baseType: !9, size: 32, offset: 32)
!22 = !DIDerivedType(tag: DW_TAG_member, name: "c", scope: !18, file: !1, line: 5, baseType: !9, size: 32, offset: 64)
!23 = !DILocation(line: 12, column: 16, scope: !6)
!24 = !DILocation(line: 13, column: 11, scope: !6)
!25 = !DILocation(line: 13, column: 7, scope: !6)
!26 = !DILocation(line: 13, column: 9, scope: !6)
!27 = !DILocation(line: 14, column: 11, scope: !6)
!28 = !DILocation(line: 14, column: 7, scope: !6)
!29 = !DILocation(line: 14, column: 9, scope: !6)
!30 = !DILocation(line: 15, column: 11, scope: !6)
!31 = !DILocation(line: 15, column: 7, scope: !6)
!32 = !DILocation(line: 15, column: 9, scope: !6)
!33 = !DILocalVariable(name: "obj2", scope: !6, file: !1, line: 17, type: !18)
!34 = !DILocation(line: 17, column: 16, scope: !6)
!35 = !DILocation(line: 18, column: 16, scope: !6)
!36 = !DILocation(line: 18, column: 7, scope: !6)
!37 = !DILocation(line: 18, column: 9, scope: !6)
!38 = !DILocation(line: 19, column: 16, scope: !6)
!39 = !DILocation(line: 19, column: 7, scope: !6)
!40 = !DILocation(line: 19, column: 9, scope: !6)
!41 = !DILocation(line: 20, column: 16, scope: !6)
!42 = !DILocation(line: 20, column: 7, scope: !6)
!43 = !DILocation(line: 20, column: 9, scope: !6)
!44 = !DILocation(line: 22, column: 2, scope: !6)
!45 = !DILocation(line: 22, column: 2, scope: !46)
!46 = !DILexicalBlockFile(scope: !6, file: !1, discriminator: 2)
!47 = !DILocation(line: 22, column: 2, scope: !48)
!48 = !DILexicalBlockFile(scope: !6, file: !1, discriminator: 4)
!49 = !DILocation(line: 22, column: 2, scope: !50)
!50 = !DILexicalBlockFile(scope: !6, file: !1, discriminator: 6)
!51 = !DILocation(line: 22, column: 2, scope: !52)
!52 = !DILexicalBlockFile(scope: !6, file: !1, discriminator: 8)
!53 = !DILocation(line: 22, column: 2, scope: !54)
!54 = !DILexicalBlockFile(scope: !6, file: !1, discriminator: 10)
!55 = !DILocalVariable(name: "obj3", scope: !6, file: !1, line: 24, type: !18)
!56 = !DILocation(line: 24, column: 16, scope: !6)
!57 = !DILocation(line: 24, column: 39, scope: !6)
!58 = !DILocation(line: 24, column: 40, scope: !6)
!59 = !DILocation(line: 24, column: 43, scope: !6)
!60 = !DILocation(line: 24, column: 46, scope: !6)
!61 = !DILocation(line: 29, column: 2, scope: !6)
!62 = !DILocation(line: 29, column: 2, scope: !46)
!63 = !DILocation(line: 29, column: 2, scope: !48)
!64 = !DILocation(line: 29, column: 2, scope: !50)
!65 = !DILocation(line: 29, column: 2, scope: !52)
!66 = !DILocation(line: 29, column: 2, scope: !54)
!67 = !DILocation(line: 32, column: 2, scope: !6)
